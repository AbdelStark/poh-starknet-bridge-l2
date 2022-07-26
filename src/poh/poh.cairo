# SPDX-License-Identifier: MIT
# Proof Of Humanity StarkNet Bridge Contracts for Cairo v0.0.1 (poh.cairo)

%lang starknet

# Starkware dependencies
from starkware.cairo.common.cairo_builtins import HashBuiltin

# Project dependencies
from poh.library import ProofOfHumanityStarkNet
from poh.model import HumanRegistration

# -----
# VIEWS
# -----

@view
func poh_bridge_l1_address{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
    poh_bridge_l1_address : felt
):
    return ProofOfHumanityStarkNet.poh_bridge_l1_address()
end

@view
func registrations{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    submission_id : felt
) -> (human_registration : HumanRegistration):
    return ProofOfHumanityStarkNet.registrations(submission_id)
end

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    owner : felt, poh_bridge_l1_address : felt
):
    return ProofOfHumanityStarkNet.constructor(owner, poh_bridge_l1_address)
end

@l1_handler
func register{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    from_address : felt, l1_submission_id : felt, l2_human_account : felt, l1_last_checked : felt
):
    return ProofOfHumanityStarkNet.register(
        from_address, l1_submission_id, l2_human_account, l1_last_checked
    )
end
