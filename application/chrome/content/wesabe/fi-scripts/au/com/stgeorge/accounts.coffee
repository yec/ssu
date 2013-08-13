# This is the accounts part of the St George Bank
# script, included by au/com/stgeorge.coffee one level up.
#
# This part handles getting and downloading accounts, and contains
# all the logic and page element references related to it.
#
wesabe.provide "fi-scripts.au.com.stgeorge.accounts",
  # The "dispatch" function is called every time a page
  # load occurs (using the ondomready callback, not onload).
  # For more information, see login.coffee in the same folder.
  dispatch: (browser, page) ->

    if page.present @e.accounts.page.index.indicator

      if !@tmp.accounts
        @collectAccounts browser, page

      if !@tmp.accounts.length
        @logoff();

      if !@tmp.account
        @tmp.account = @tmp.accounts.shift()

      if @tmp.account
        @goToAccountPage browser

    if page.present @e.accounts.page.details.indicator

      if page.present @e.transHistExport
        @download page

  actions:
    download: (page) ->
      page.click @e.transHistExport

    collectAccounts: (browser, page) ->
      @tmp.accounts = [
        accountNumber: 2
      ]

    goToAccountPage: (browser) ->
      browser.go 'https://ibanking.stgeorge.com.au/ibank/accountDetails.action?index=' + @tmp.account.accountNumber

    goMyAccountsPage: ->
      job.update "account"
      browser.go 'https://ibanking.stgeorge.com.au/ibank/viewAccountPortfolio.action'

  elements:
    accounts:
      page:
        index:
          indicator: [
            '//h1[contains(string(.), "My Accounts")]'
          ]

        details:
          indicator: [
            '//h1[contains(string(.), "Account Details")]'
          ]

      list:
        item:
          container: [
          ]

    downloadLink: [
      '//a[contains(@href, "Export")][contains(string(.), "Export")]'
    ]

    transHistExport: [
      '//a[@name="transHistExport"]'
    ]
