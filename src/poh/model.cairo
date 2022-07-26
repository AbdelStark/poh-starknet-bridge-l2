# SPDX-License-Identifier: MIT
# Proof Of Humanity StarkNet Bridge Contracts for Cairo v0.0.1 (model.cairo)

%lang starknet

struct HumanRegistration:
    # address of the human account on L2
    member l2_human_account : felt
    # timestamp of the last check from L1
    member l1_last_checked : felt
end
