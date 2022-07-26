# SPDX-License-Identifier: MIT
# Proof Of Humanity StarkNet Bridge Contracts for Cairo v0.0.1 (test_poh.cairo)

%lang starknet

# Starkware dependencies
from starkware.cairo.common.cairo_builtins import HashBuiltin

# Project dependencies
from poh.library import ProofOfHumanityStarkNet
from poh.model import HumanRegistration

const L1_BRIDGE_ADDRESS = 'l1-bridge-address'
const ADMIN = 'admin'
const ANYONE_1 = 'user-1'
const ANYONE_2 = 'user-2'
const ANYONE_3 = 'user-3'

# -------
# STRUCTS
# -------

struct Signers:
    member admin : felt
    member anyone_1 : felt
    member anyone_2 : felt
    member anyone_3 : felt
end

struct Mocks:
    member l1_brige_address : felt
end

struct TestContext:
    member signers : Signers
    member mocks : Mocks
end

# Test case:
# Category: NOMINAL
@external
func test_nominal_case{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    alloc_locals
    let (local context : TestContext) = test_internal.prepare()

    return ()
end

namespace test_internal:
    func prepare{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
        test_context : TestContext
    ):
        alloc_locals

        local signers : Signers = Signers(admin=ADMIN, anyone_1=ANYONE_1, anyone_2=ANYONE_2, anyone_3=ANYONE_3)

        local mocks : Mocks = Mocks(
            l1_brige_address=L1_BRIDGE_ADDRESS,
            )

        local context : TestContext = TestContext(
            signers=signers,
            mocks=mocks,
            )

        ProofOfHumanityStarkNet.constructor(signers.admin, mocks.l1_brige_address)
        return (test_context=context)
    end
end
