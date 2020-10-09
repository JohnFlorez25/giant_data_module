function createFrequencyEventsMatrixCSV(frequencyEventsMatrix::DataFrame)
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "frequency_events_users_giant.csv"
            )
    CSV.write(path, frequencyEventsMatrix)
end

function createFrequencyEventsMatrixNotUsersCSV(
    frequencyEventsDataFrameWithoutUsers::DataFrame)
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "frequency_events_not_users_giant.csv"
            )
    CSV.write(path, frequencyEventsDataFrameWithoutUsers)
end

function createNormalizationFrequencyMatrixCSV(
    normalizeFrequencyMatrixEvents::Array{Float64,2})
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "normalize_data_frequency_matrix_giant.csv"
            )
    CSV.write(path, DataFrame(normalizeFrequencyMatrixEvents))
end