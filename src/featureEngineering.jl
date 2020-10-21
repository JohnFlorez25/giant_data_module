include("graphicsGenerator.jl")
include("csvGenerator.jl")

# Path with CSV Events GIANT info to processing
path = joinpath(@__DIR__, "..", "data", "data_giant_feature_engineering.csv")

# Define events Data Frame
featureDataFrame = DataFrame(CSV.File(path))

# ---------- OBTAIN ACTION BY USER --------

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

# ---------- OBTAIN CONNECTIONS PER DAY --------

# Converting variables to String type of the featureDataFrame
featureDataFrame[
        !,
        [:year, :month, :day, :hour, :minute, :second]
        ]=convert(
                Array{Int64}, 
                featureDataFrame[!,[:year, :month, :day, :hour, :minute, :second]]
        );

# Grouping users according to the action taken
groupbyLogin = groupby(featureDataFrame, [:month, :day, :action]);

# Obtaining the number of shares according to their type
loginDataFrameCount=combine(groupbyLogin, :action => sum);

# Grouping by action performed
groupbyLoginAction = groupby(loginDataFrameCount, :action);

# Selecting the maximum value of columns of group 3 (action loggedin)
topsize=size(groupbyLoginAction[3],1);

# Convert Group by Login Data to DataFrame
groupbyLoginPerDay = convert(DataFrame,groupbyLoginAction[3] )

# Calling graphic createActionByUserPlot of graphicsGenerator
createConnectionPerDayPlot(topsize, groupbyLoginPerDay)