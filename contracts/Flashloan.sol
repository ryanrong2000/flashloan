pragma solidity ^0.6.6;

import "./aave/FlashLoanReceiverBase.sol";
import "./aave/ILendingPoolAddressesProvider.sol";
import "./aave/ILendingPool.sol";

contract Flashloan is FlashLoanReceiverBase {

    constructor(address _addressProvider) FlashLoanReceiverBase(_addressProvider) public {}

    /**
        This function is called after your contract has received the flash loaned amount
     */
    function executeOperation(address _reserve, uint256 _amount, uint256 _fee, bytes calldata _params) external override
    {
        require(_amount <= getBalanceInternal(address(this), _reserve), "Invalid balance, was the flashLoan successful?");

        //
        // Your logic goes here.
        // !! Ensure that *this contract* has enough of `_reserve` funds to payback the `_fee` !!
        //

        uint totalDebt = _amount.add(_fee);
        transferFundsBackToPoolInternal(_reserve, totalDebt);
    }

    /**
        Flash loan 1000000000000000000 wei (1 ether) worth of `_asset`
        //kovan dai 0xff795577d9ac8bd7d90ee22b6c1703490b6512fd
        kovan dai 0x6dDFD6364110E9580292D9eCC745F75deA7e72c8
        kovan weth 0xe2735Adf49D06fBC2C09D9c0CFfbA5EF5bA35649
        ropsten dai 0xad6d458402f60fd3bd25163575031acdce07538d
        ropsten weth 0xb603cea165119701b58d56d10d2060fbfb3efad8
     */
    function flashloan(address _asset, uint _amount) public onlyOwner {
        bytes memory data = "";
        //uint amount = 1 ether;

        ILendingPool lendingPool = ILendingPool(addressesProvider.getLendingPool());
        lendingPool.flashLoan(address(this), _asset, _amount, data);
    }
}
