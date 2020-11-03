include("graphicsGenerator.jl")
include("csvGenerator.jl")

# Path with CSV Events GIANT info to processing
path = joinpath(@__DIR__, "..", "data", "events_data_09_10_2020.csv")

# Define events Data Frame
eventsDataFrame = DataFrame(CSV.File(path))

# Showing the load data
first(eventsDataFrame,5)

# Data Frame size
println("Data Frame Size ",size(eventsDataFrame))

# Converting variables to String type
eventsDataFrame[!,[:eventname, :component, :action, :target, :crud]]=
    convert(Array{String}, 
            eventsDataFrame[!,[:eventname, :component, :action, :target, :crud]]
    )
    
# Identifying categories of the eventname variable

l = unique(eventsDataFrame[!,:eventname])

# Changing categorical values ​​to numeric values ​​in EventName column
eventsDataFrame[!,:eventname]=
    replace(
            eventsDataFrame[!,:eventname], 
            Pair.(l, axes(l, 1))...
    )

# Creating Data Frame with the Users and their Events did in GIANT    
dfUserEvents = DataFrame(USER_ID = eventsDataFrame[!,:userid], EVENT_TYPE = convert(Array{Int64}, eventsDataFrame[!,:eventname]) )

# Calling graphic createEventsUsersGraphic of graphicsGenerator
createEventsUsersPlot(dfUserEvents)

#=
    One Hot Encoding
    We are going to convert the event type to form multiple numerical columns 
    - (data normalization) since we have these categories. 
    This will help us so that the variables can be introduced into 
    the machine learning algorithms to do a better job of predicting.
=#

# applying one hot encoding technique
scaled_feature = Lathe.preprocess.OneHotEncode(dfUserEvents,:EVENT_TYPE)

# Creating an Event Matrix - Frequency matrix with multiple events per user

EventsMatrix=select!(dfUserEvents, Not(:EVENT_TYPE))

# Getting an array of events performed by a user
to_group_events = names(EventsMatrix[!, Not(:USER_ID)])

# Grouping a single user with the sum of the events carried out
frequencyEventsMatrix=
    combine(
            groupby(EventsMatrix, :USER_ID), 
            to_group_events .=> sum .=> to_group_events
    )

# Organizing the frequency matrix of events by user identifier
frequencyEventsMatrix=sort!(frequencyEventsMatrix, [:USER_ID])

# Generating csv with the frequency matrix events
createFrequencyEventsMatrixCSV(frequencyEventsMatrix)

# Creating frequency event matrix not users - (Going to use in normalization )
frequencyEventsDataFrameWithoutUsers=frequencyEventsMatrix[!, Not(:USER_ID)]

#Exporting in CSV the frequency events matrix without users
createFrequencyEventsMatrixNotUsersCSV(frequencyEventsDataFrameWithoutUsers)
