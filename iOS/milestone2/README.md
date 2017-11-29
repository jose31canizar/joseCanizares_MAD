## Invision mockup: https://invis.io/8KDT4VLUG#/256805675_Active

## Pseudo code of logic & algorithms:
  For sorting I will be taking advantage of the swift sort function and its comparable protocol.

  Sort
    sort alphabetically
    sort by last viewed date
    sort to static position the user leaves them in

  Filter/Group
    sort by cycle setting
    sort by complete or incomplete

  Favorites
    sort according to whether favorite or nonfavorite

  Search
    Use a search api

  Create
    two text fields input data that creates a list and sends it back to the main controller

  List
    The List class consists of:
      title
      an array of list items
      last viewed date
      cycle setting (daily, weekly, or regular)
      complete or incomplete (reset according to cycle setting (regular is never reset))
      favorite or not favorite

  Data Persistence
    The main controller will keep track of:
      List & list item data
      static sorting positions user drags lists into
      last chosen toolbar state (sort, filter, blockview, favorites)

## Assets
