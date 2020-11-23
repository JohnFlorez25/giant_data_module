include("graphicsGenerator.jl")
include("csvGenerator.jl")

# Path with CSV Events GIANT info to processing
path = joinpath(@__DIR__, "..", "data", "events_30_10_2020.csv")

# Defining events Data Frame
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
    map((x) -> Dates.format(x, "yyyy-mm-dd HH:MM:SS") , 
        eventsDataFrame[!,:timecreated])

# Adding the date and hour columns to our dataset
eventsDataFrame=hcat(
        eventsDataFrame, 
        DataFrame(reduce(vcat, 
        permutedims.(split.(eventsDataFrame[!,:timecreated], ' '))), 
        [:date, :time,])
        )

# Adding the year, month and day columns to our dataset
eventsDataFrame=hcat(
        eventsDataFrame, 
        DataFrame(reduce(vcat, 
        permutedims.(split.(eventsDataFrame[!,:date], '-'))), 
        [:year, :month, :day])
        )

# Adding the hour, minute and second columns to our dataset
eventsDataFrame=hcat(
        eventsDataFrame, 
        DataFrame(reduce(vcat, 
        permutedims.(split.(eventsDataFrame[!,:time], ':'))), 
        [:hour, :minute, :second])
        )
# Creating a new Data Frame to start generating visualization pieces of what is happening in the manager
featureDataFrame=
    eventsDataFrame[
            !,
            [:userid, :eventname, :component, :action, :target, :year, 
            :month, :day, :hour, :minute, :second]
        ]
# Export in CSV the data for the feature engineering process
createFeatureEngineeringDataCSV(featureDataFrame)