include("graphicsGenerator.jl")

# Path with CSV Events GIANT info
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
createEventsUsersGraphic(dfUserEvents)