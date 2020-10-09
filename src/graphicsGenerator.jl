# Graphic Users and their Events did in GIANT 
function createEventsUsersGraphic(dfUserEvents::DataFrame)
    scatter(
        dfUserEvents.USER_ID, 
        dfUserEvents.EVENT_TYPE, 
        marker_z=dfUserEvents.EVENT_TYPE,
        color=:lightrainbow,
        title="Eventos ejecutados por usuario",
        ylabel ="Evento ejecutado",
        xlabel="Identificador del Usuario",
        legend=false,
        size=(1100,400)
    )
    # Path to save the images
    path = joinpath(@__DIR__, "..", "images", "events-executed-by-user.png")
    # Saved png format
    savefig(path)   
end
  