import os

# Disable the numpy thread parallelisim (we use MPI instead)
os.environ["OMP_NUM_THREADS"] = "1"
os.environ["OPENBLAS_NUM_THREADS"] = "1"
os.environ["MKL_NUM_THREADS"] = "1"
os.environ["VECLIB_MAXIMUM_THREADS"] = "1"
os.environ["NUMEXPR_NUM_THREADS"] = "1"


import numpy as np
from mtpoptimizer import (
    run_optimization,
    assemble_new_tree,
    parse_mtp_file,
    write_mtp_file,
)

# --- Configuration ---
DATA_DIR = "data"
MTP_FILE = os.path.join(DATA_DIR, "20.almtp")
XTWX_FILE = os.path.join(DATA_DIR, "xtwx.bin")  # Get this from the MLIP-3 fork
XTWY_FILE = os.path.join(DATA_DIR, "xtwy.bin")  # Get this from the MLIP-3 fork

OUTPUT_DIR = "optimization_results"

if __name__ == "__main__":

    xtwx = np.fromfile(XTWX_FILE, dtype=np.float64)
    xtwy = np.fromfile(XTWY_FILE, dtype=np.float64)
    xtwx = np.reshape(xtwx, (len(xtwy), len(xtwy)))

    result = run_optimization(
        mtp_file=MTP_FILE,
        xtwx=xtwx,
        xtwy=xtwy,
        yty=1308558.94848743616603,  # Get this from the MLIP-3 fork
        neigh_count=20.528098,  # Get this from the MLIP-3 fork
        regularization=1e-4,  # You will get a warning if you should increase this
        output_dir=OUTPUT_DIR,
        end_condition=(
            "time",
            10,
        ),  # You can also specify the number of generations with n_gen
        pop_size=96,  # 512 is good for most production runs
        show_plot=True,
        seed=None,
        algorithim="nsga",  # moead or nsga. Start with nsga.
    )

    if result:
        print("\n--- Post-processing: Assembling a new MTP ---")
        # Example: Choose the solution with the lowest SSE from the Pareto front
        pareto_front = result.F
        pareto_pop = result.X

        # Get the individual with the lowest SSE
        best_sse_idx = pareto_front[:, 1].argmin()
        best_sse_mask = pareto_pop[best_sse_idx].astype(bool)

        print(f"Lowest SSE found: {pareto_front[best_sse_idx][1]:.4f}")
        print(f"Corresponding cost: {pareto_front[best_sse_idx][0]:.4f}")

        original_mtp = parse_mtp_file(MTP_FILE)
        new_mtp_dict = assemble_new_tree(original_mtp, best_sse_mask)

        output_mtp_path = os.path.join(OUTPUT_DIR, "pruned_mtp.almtp")
        write_mtp_file(new_mtp_dict, output_mtp_path)
