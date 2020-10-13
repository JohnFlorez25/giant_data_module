include("graphicsGenerator.jl")
include("csvGenerator.jl")

# Path with CSV Events GIANT info to processing
path = joinpath(@__DIR__, "..", "data", "events_data_09_10_2020.csv")

# Define events Data Frame
eventsDataFrame = DataFrame(CSV.File(path))

# Converting variables to String type
eventsDataFrame[
    !,
    [:eventname, :component, :action, :target, :crud]
    ]=convert(
            Array{String}, 
            eventsDataFrame[
                !,
                [:eventname, :component, :action, :target, :crud]
            ]
        )

# Converting Timestamp from variable timecreated to date format
eventsDataFrame[!,:timecreated] = 
    map((x) -> unix2datetime(x), eventsDataFrame[!,:timecreated]);

# Converting DataTime to String
eventsDataFrame[!,:timecreated] = 
    map((x) -> Dates.format(x, "yyyy-mm-dd") , 
        eventsDataFrame[!,:timecreated])

# Adding the year, month and day columns to our dataset
eventsDataFrame=hcat(
        eventsDataFrame, 
        DataFrame(reduce(vcat, 
        permutedims.(split.(eventsDataFrame[!,:timecreated], '-'))), 
        [:year, :month, :day])
        )

# ---------- OBTAIN ACTION BY USER --------
# Creating a new Data Frame to start generating visualization pieces of what is happening in the manager
featureDataFrame=
    eventsDataFrame[
            !,
            [:userid, :component, :action, :target, :year, :month, :day]
        ]

# IDENTIFYING CATEGORIES of the action variable
actionID = unique(featureDataFrame[!,:action]);

# Obtaining the types of actions that users execute and assigning an identifier to each action
featureDataFrame[!,:action]=
    replace(
            featureDataFrame[!,:action], 
            Pair.(actionID, axes(actionID, 1))...
    );

# Grouping users according to the action taken
groupbyAction = groupby(featureDataFrame, :action);

# Obtaining the number of shares according to their type
actionDataFrameCount=combine(groupbyAction, :action => sum);

# Adding the action name to the actionDataFrame
insertcols!(actionDataFrameCount, 2, :action_name => actionID);

# Organizing the frequency matrix of events by user identifier
actionDataFrameCount=
    sort!(
            actionDataFrameCount, 
            [:action_sum], 
            rev= true  
    )

# Calling graphic createActionByUserPlot of graphicsGenerator
createActionCountPlot(actionDataFrameCount)

