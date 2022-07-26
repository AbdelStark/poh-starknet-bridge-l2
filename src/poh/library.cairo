# SPDX-License-Identifier: MIT
# Proof Of Humanity StarkNet Bridge Contracts for Cairo v0.0.1 (libary.cairo)

%lang starknet

# Starkware dependencies
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.bool import TRUE, FALSE

# OpenZeppelin dependencies
from openzeppelin.access.ownable.library import Ownable

# Project dependencies
from poh.model import HumanRegistration
from poh.events import HumanRegistered

# ------
# STORAGE
# ------

# Address of the ProofOfHumanityStarkNetBridge contract on L1.
@storage_var
func poh_bridge_l1_address_() -> (poh_bridge_l1_address : felt):
end

# Mapping of registrations
@storage_var
func registrations_(submission_id : felt) -> (human_registration : HumanRegistration):
end

namespace ProofOfHumanityStarkNet:
    # ------
    # VIEWS
    # ------

    ###
    # Returns the address of the ProofOfHumanityStarkNetBridge contract on L1.
    ###
    func poh_bridge_l1_address{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        ) -> (poh_bridge_l1_address : felt):
        return poh_bridge_l1_address_.read()
    end

    ###
    # Get a registration for a submission id (address on L1).
    # @param submission_id the identifier of the registration
    ###
    func registrations{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        submission_id : felt
    ) -> (human_registration : HumanRegistration):
        let (human_registration) = registrations_.read(submission_id)
        return (human_registration)
    end

    # ------
    # CONSTRUCTOR
    # ------
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        owner : felt, poh_bridge_l1_address : felt
    ):
        Ownable.initializer(owner)
        poh_bridge_l1_address_.write(poh_bridge_l1_address)
        return ()
    end

    # ------
    # EXTERNAL FUNCTIONS
    # ------
    func register{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        from_address : felt,
        l1_submission_id : felt,
        l2_human_account : felt,
        l1_last_checked : felt,
    ):
        # Check message provenance
        let (poh_bridge_l1_address) = poh_bridge_l1_address_.read()
        with_attr error_message(
                "ProofOfHumanityStarkNet: message was not sent by the official L1 contract"):
            assert from_address = poh_bridge_l1_address
        end
        let registration = HumanRegistration(l2_human_account, l1_last_checked)
        # Save registration
        registrations_.write(l1_submission_id, registration)
        return ()
    end
end

namespace internal:
end
