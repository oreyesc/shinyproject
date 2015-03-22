# shinyproject



# Shiny Application

## Objectives 
The application includes the following:

- Some form of input (widget: textbox, radio button, checkbox, ...)
- Some operation on the ui input in sever.R
- Some reactive output displayed as a result of server calculations
- You must also include enough documentation so that a novice user could use your application.
- The documentation should be at the Shiny website itself. Do not post to an external link.

*****

## Components
1. **ui.R**: user-interface definition of a Shiny web application.
2. **server.R**: logic for a Shiny web application.

*****

## Functionality
In the **ui.R** the user has tow parts:

1. **Side Bar**: has the option to choose:
    - Select a dataset: `iris`, `mtcars` or `trees`.
    - Select two variables: `X` and `Y` variables.
    - Select density:  from 50 to 250.
    - Select a colour for the graphs.
    - Select one type of graph:
      * Bar Plot.
      * Box Plot.
      * Dot Plot.
      * Line Chart.
      * Sactter Plot.
2. **mainPanel**: has a `tabPanel` with:
   - _Dinamyc Plot_: shows the selected graphic created with the information of the selected `dataset`.
   - _Structure_: shows the selected `dataset` structure.
   - _Summary_: shows the selected `dataset` summary.
   - _Data__: shows the `data`of the `X` variable.
3. All actions are executed in a `reactive` mode on the **server.R** side.

In the **server.R** are:

|   Variable   | Functionality | 
| ------------ | ------------- | 
| colm         | contains the value of selected `dataset`  
| var          | contains the `names` of the columns of the selected `dataset`.  | 
| dataset      | contains the selected `dataset`.|
| graph        | contains the selected graphic.|

##Libraries:
`shiny`, `ggplot`, `car`, `RcppEigen`

*******

#### Link to Shinyapps

[Shiny Application](https://sigma360.shinyapps.io/shinyproject_coursera/).
