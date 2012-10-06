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
    # replace with your own custom logic for determining login status
    return unless page.present @e.logoff.link

    # TODO: fill out logic for finding and downloading accounts

  actions:
    # TODO: fill this out (see login.coffee for more info)
    sample: ->

  elements:
    # TODO: fill this out (see login.coffee for more info)
    accounts: {}
