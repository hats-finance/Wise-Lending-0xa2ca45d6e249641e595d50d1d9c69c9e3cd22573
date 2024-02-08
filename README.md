# Audit Competition for Wise-Lending
This repository is for the audit competition for the Wise-Lending.
To participate, submit your findings only by using the on-chain submission process on https://app.hats.finance/vulnerability .
## How to participate
- follow the instructions on https://app.hats.finance/
## Good luck!
We look forward to seeing your findings.
* * *
# wise-lending
### Process and Testing
For audit purpose and testing of WiseLending

### Do an npm install / yarn install / bun install

👷 To run all tests together can use foundry/forge
```
yarn foundry-test
```

### Test coverage
🧪 To generate test-coverage report simply run this command (without starting local chain)

```
yarn foundry-coverage
```

### Deployment
🚀 To deploy automatically add .env file and specify PRIVATE_KEY=YOUR_KEY and ETHERSCAN_API_KEY=YOUR_API_KEY then use command below or equivalent in package.json


### P.S.
there are also some additional tests in /test folder for hardhat setup