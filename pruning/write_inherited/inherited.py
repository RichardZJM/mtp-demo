import numpy as np
import os

from mtpoptimizer import (
    assemble_new_tree,
    parse_mtp_file,
    write_mtp_file,
)
from mtpoptimizer.sse import SSECalculator

if __name__ == "__main__":
    sample_individual = np.genfromtxt("mask.csv", delimiter=",")

    DATA_DIR = "../prune/data"
    ORIG_MTP_FILE = os.path.join(DATA_DIR, "20.almtp")
    XTWX_FILE = os.path.join(DATA_DIR, "xtwx.bin")
    XTWY_FILE = os.path.join(DATA_DIR, "xtwy.bin")

    xtwx = np.fromfile(XTWX_FILE, dtype=np.float64)
    xtwy = np.fromfile(XTWY_FILE, dtype=np.float64)
    xtwx = np.reshape(xtwx, (len(xtwy), len(xtwy)))
    yty = 1308558.94848743616603

    original_mtp = parse_mtp_file(ORIG_MTP_FILE)
    calc = SSECalculator(xtwx, xtwy, yty, regularization=1e-4)

    mask = sample_individual.astype(bool)
    # We need to append a True value for each species since we never prune species coeffs
    full_mask = np.append(np.full((1), True, dtype=bool), mask)
    theta, sse = calc.calculate(full_mask, get_theta=True)
    new_mtp_dict = assemble_new_tree(original_mtp, mask, theta)
    write_mtp_file(new_mtp_dict, "pruned.almtp")
