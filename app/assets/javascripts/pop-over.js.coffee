# adds bootstrap popovers to group activity indicators
$ ->
  $(".group-activity").tooltip
    placement: "top"
    title: 'There have been new comments since you last visited the group.'


# adds bootstrap popovers to vote buttons
$ ->
  $(".position").popover
    placement: "top"


# adds bootstrap popovers to preview pies
$ ->
  if $("body.groups.show").length > 0 || $("body.dashboard.show").length > 0
    $(".pie").popover
      placement: "right"


