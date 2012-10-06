# This is the login part of the St George Bank
# script, included by au/com/stgeorge.coffee one level up.
#
# This part handles logging in, and contains all the
# logic and page element references related to it.
#
wesabe.provide "fi-scripts.au.com.stgeorge.login",
  # This is your opportunity to look at the page, figure
  # out where you are, and go to the next page, trigger a
  # download, or pass/fail the job.
  #
  # page - A dom/Page providing access to the just-loaded page,
  #        allows finding things on the page, filling in forms, etc.
  #        While most of the time this will be the top-level Page in
  #        a Browser, it might also represent a frame inside another
  #        Page.
  #
  # browser - A dom/Browser allows navigating away from the current
  #           URL and getting the current top-level URL.
  #
  #
  # Examples
  #
  #   # update the job status to say you're logging in
  #   @job.update 'auth.creds'
  #
  #   # fail the current job because the user credentials are wrong
  #   @job.fail 401, 'auth.creds.invalid'
  #
  #   # pass the current job because you got what you came here for
  #   @job.succeed()
  #
  #
  #   # temporarily store a list of account numbers for use later
  #   @tmp.accountNumbers = (option.value for option in page.select @e.accounts.options)
  #
  #   # NOTE: You may NOT store page elements in @tmp.
  #   # Any page elements retrieved using page.find(), page.select(), etc
  #   # will likely not be valid the next time you try to do something
  #   # with them, for example passing them to page.click().
  #
  dispatch: (browser, page) ->
    # replace with your own custom logic for determining login status
    return if page.present @e.logoff.link

    # replace with your own custom logic for how to log in
    #   NOTE: the order of the below is important
    #
    #   If you were to look for the username text field first
    #   then you would miss a possible error message on most
    #   websites, which show both an error message and the same
    #   form for the user to fill out again.
    #
    #   Because of this fact your dispatch will often start to look
    #   like it's doing things backwards, looking for the cases that
    #   come later, like errors logging in, before the cases that
    #   chronologically precede them, like doing the actual login.
    #
    if page.present @e.login.error.user
      @job.fail 401, 'auth.user.invalid'
    else if page.present @e.login.error.pass
      @job.fail 401, 'auth.pass.invalid'
    else if page.present @e.login.error.creds
      @job.fail 401, 'auth.creds.invalid'
    else if page.present @e.login.error.general
      @job.fail 401, 'auth.unknown'
    else if page.present @e.login.error.noAccess
      @job.fail 403, 'auth.noaccess'
    else if page.present @e.login.user.field
      @login browser, page

  # Actions are discrete steps that can be taken,
  # and often leave the current page, triggering
  # another call to dispatch.
  #
  # An example might be "login", as shown below,
  # which fills out the login form and submits it.
  #
  actions:
    # sample -- replace this with your own custom logic
    login: (browser, page) ->
      page.fill @e.login.user.field, @answers.username
      page.fill @e.login.security.field, @answers.securitynumber
      page.fill @e.login.pass.field, @answers.password
      # causes the form to be submitted, triggering another page
      # load, which then calls dispatch again -- hopefully as a
      # logged-in user this time
      page.click @e.login.continueButton

    # sample -- replace this with your own custom logic
    logoff: (browser, page) ->
      page.click @e.logoff.link
      # notify our owner that the job succeeded
      @job.succeed()

  # elements are xpaths or sets of xpaths that
  # illustrate how to access a particular element
  # on a page
  #
  # used by the page.* methods, available as "e"
  # in dispatch and actions
  elements:
    login:
      user:
        field: [
          # for example:
          '//form[@name="logonForm"]//input[@type="text"][@name="userId"]'
        ]

      security:
        field: [
          # for example:
          '//form[@name="logonForm"]//input[@type="password"][@name="securityNumber"]'
        ]

      pass:
        field: [
          # for example (this one has two, the 2nd being a fallback):
          #'//input[@type="password"][@name="pass"]'
          '//form[@name="logonForm"]//input[@type="password"][@name="password"]'
        ]

      continueButton: [
          '//form[@name="logonForm"]//input[@type="submit"][@name="Login"]'
      ]

      # possible error messages that you'll encounter logging in
      # it's likely that the bank will either show "invalid user"
      # and "invalid password" OR "invalid username and/or password",
      # but not both, so you'll probably need to trim some of this
      error:
        user: [
          # for example
          '//text()[contains(., "Invalid username")]'
        ]

        pass: [
          # for example
          '//text()[contains(., "Invalid password")]'
        ]

        creds: [
          # for example
          '//text()[contains(., "Invalid username or password")]'
        ]

        general: [
          # for example
          '//text()[contains(., "Could not log you in")]'
        ]

        noAccess: [
          # for example
          '//text()[contains(., "Your account has been locked")]'
        ]

    logoff:
      link: [
        # for example
        '//a[contains(string(.), "Logoff") or contains(string(.), "Logout")][contains(@href, "Logff")]'
      ]

    # For most security questions there are text nodes containing
    # the whole question and <input/> elements to put answers in.
    # If this fits St George Bank then you can simply
    # fill out these xpaths below and call the
    # "answerSecurityQuestions" action.
    #
    # If not, you'll need to create your own action to handle
    # the custom logic for St George Bank.
    security:
      # the elements of the questions
      questions: [
        # for example:
        '//form[@name="sq"]//label[contains(string(.), "?")]//text()'
      ]

      # the <input/> element for the answers
      answers: [
        # for example:
        '//form[@name="sq"]//input[@type="text"][contains(@name, "sq_answer")]'
      ]

      # optional, usually labelled "Don't ask me again on this computer"
      setCookieCheckbox: [
      ]

      # the "Next" or "Continue" button to submit the form
      continueButton: [
      ]
