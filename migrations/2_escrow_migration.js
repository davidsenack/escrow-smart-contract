const Escrow = artifacts.require('Escrow');

module.exports = function(deployer, network, accounts) {
    deployer.deployer(Escrow, ganache, accounts[0])
};