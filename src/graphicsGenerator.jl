# Ploting Users and their Events did in GIANT 
function createEventsUsersPlot(dfUserEvents::DataFrame)
    scatter(
        dfUserEvents.USER_ID, 
        dfUserEvents.EVENT_TYPE, 
        marker_z=dfUserEvents.EVENT_TYPE,
        color=:lightrainbow,
        title="Eventos ejecutados por usuario",
        ylabel ="Evento ejecutado",
        xlabel="Identificador del Usuario",
        legend=false,
        size=(800,400)
    )
    # Path to save the images
    path = joinpath(@__DIR__, "..", "images", "events-executed-by-user.png")
    # Saved png format
    savefig(path)   
end
  
# Ploting Clusters' Optimal Number using elbow method
function createClusterOptimalNumberPlot(
    typeOfData,x::UnitRange{Int64},y::Array{Float64,1})
    plot(
        x, 
        y, 
        title = "Clusters' Optimal  Number", 
        xlabel = "Clusters' Number", 
        ylabel = "Inertia", 
        lw = 3, 
        marker=:circle, 
        ms=6, 
        mc=:red, 
        size=(800,400)
    )
    # Path to save the images
    if typeOfData == 1
        path = joinpath(@__DIR__, "..", "images", "cluster-optimal-number-high.png")
    elseif typeOfData == 2
        path = joinpath(@__DIR__, "..", "images", "cluster-optimal-number-low.png")
    end
    # Saved png format
    savefig(path)  
end

# Ploting Actions most performed by users
function createActionCountPlot(actionDataFrameCount::DataFrame)
    x=actionDataFrameCount[1:4,:action_name]
    y=actionDataFrameCount[1:4,:action_sum]
    plot(
        x, 
        y, 
        seriestype = :bar, 
        size=(1100,300), 
        title = "Actions most performed by users", 
        legend=false, 
        orientation=:h, 
        yflip=true
    )
    
    # Path to save the images
    path = joinpath(@__DIR__, "..", "images", "action-count-iteration.png")
    # Saved png format
    savefig(path)   
end

# Ploting Connections Per Day
function createConnectionPerDayPlot(
            topSize::Int64,
            groupbyLoginAction::DataFrame
        )
    x = 1:topSize; 
    y = groupbyLoginAction[!,:action_sum]; # These are the plotting data
    plot(
        x, 
        y, 
        title = "Connections per day", 
        xlabel = "Day", 
        ylabel = "Connection's Number", 
        lw = 3, 
        marker=:circle, 
        ms=5, 
        mc=:orange,
        legend=false, 
        size=(1100,300)
    )
    
    # Path to save the images
    path = joinpath(@__DIR__, "..", "images", "connection-per-day.png")
    # Saved png format
    savefig(path)   
end

# Ploting Actions most performed by users
function createHighestEventsExecuted(userByEventsSumDataFrame::DataFrame)
    x=userByEventsSumDataFrame[!,:USER_ID]
    y=userByEventsSumDataFrame[!,:SUM_EVENTS]
    plot(
        x, 
        y, 
        seriestype = :bar, 
        size=(700,300), 
        title = "Highest number of events executed", 
        xlabel = "user id", 
        ylabel = "events sum", 
        label = ["Events" "Events"] 
    )
    media=floor(Int,mean(userByEventsSumDataFrame[!,:SUM_EVENTS]))
    hline!(
        [media], 
        color = "green", 
        linestyle = :dash, 
        linewidth = 4,
        label = ["Mean" "Mean"]
    )
    # Path to save the images
    path = joinpath(@__DIR__, "..", "images", "highest-events-executed.png")
    # Saved png format
    savefig(path)   
end