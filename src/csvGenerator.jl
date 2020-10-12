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

function createDimensionalityReductionDataCSV(
    dimensionality_reduction_data::Array{Float32,2})
    path = joinpath(
                    @__DIR__, 
                    "..", 
                    "data", 
                    "dimensionality_reduction_data.csv"
            )
    CSV.write(path, DataFrame(dimensionality_reduction_data))
end

function createClusteringResultsCSV(
    typeOfData::Int64,
    dataClustering::DataFrame)

    if typeOfData == 1
        path = joinpath(
                        @__DIR__, 
                        "..", 
                        "data", 
                        "high_data_clustering_giant_events.csv"
                )
    elseif typeOfData == 2
        path = joinpath(
                        @__DIR__, 
                        "..", 
                        "data", 
                        "low_data_clustering_giant_events.csv"
                )
    end

    CSV.write(path, dataClustering)
    
end