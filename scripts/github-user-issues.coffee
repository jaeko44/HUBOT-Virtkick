# Description:
#   Show open issues from a Users Profile
#
# Dependencies:
#   "underscore": "1.3.3"
#   "underscore.string": "2.1.1"
#   "githubot": "0.4.x"
#
# Configuration:
#   HUBOT_GITHUB_TOKEN
#   HUBOT_GITHUB_USER
#   HUBOT_GITHUB_REPO
#   HUBOT_GITHUB_USER_(.*)
#   HUBOT_GITHUB_API
#
# Commands:
# hubot show [my/ Another User] issues
#
# Notes:
#   If, for example, HUBOT_GITHUB_USER_JOHN is set to GitHub user login
#   'johndoe1', you can ask `show john's issues` instead of `show johndoe1's
#   issues`. This is useful for mapping chat handles to GitHub logins.
#
#
# Author:
#   jaeko44/Jonathan Philipos for use by VirtKick