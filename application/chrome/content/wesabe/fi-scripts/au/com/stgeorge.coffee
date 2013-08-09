# This file is the main file for the St George Bank script.
# Scripts for downloading data from financial institutions
# are called "players".
wesabe.download.Player.register
  fid: 'au.com.stgeorge'
  org: 'StGeorge Bank'

  # change to on if frames have meaningful content,
  # and that "dispatch" should be run for the document
  dispatchFrames: off

  # tells the player to remove the current account (tmp.account)
  # when a download completes. this is useful when only one account
  # may be downloaded as a time
  #
  # tells Player to run the "nextAccount" action after a download
  afterDownload: 'nextAccount'

  actions:
    # The "main" action is the entry point into the script,
    # and is the first thing that is run. It should trigger
    # a page load, which calls "dispatch" (see login.js).
    main: (browser) ->
      # TODO: change the url to go to the login page for St George Bank
      browser.go "https://ibanking.stgeorge.com.au/ibank/loginPage.action"

  # the "includes" array allows you to build this Player from
  # multiple files, splitting it up by functionally discrete parts
  #
  # the two that nearly all Players will have is how to log in,
  # and how to navigate and download accounts. samples of each
  # are provided in login.js and accounts.js alongside this file
  includes: [
    'fi-scripts.au.com.stgeorge.login'
    'fi-scripts.au.com.stgeorge.accounts'
  ]
