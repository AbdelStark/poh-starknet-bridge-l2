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
