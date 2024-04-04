const { jestConfig } = require("@salesforce/sfdx-lwc-jest/config");
module.exports = {
  ...jestConfig,
  coverageThreshold: {
    global: {
      lines: 75,
      statements: 75
    }
  }
};