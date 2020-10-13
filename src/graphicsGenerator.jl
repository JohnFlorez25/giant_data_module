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