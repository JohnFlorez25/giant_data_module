# Generla function to convert data frame to matrix values

function convertDataFrameToMatrix(path::String)
    # Define obtain Data in DataFame
    data= DataFrame(CSV.File(path))
    # Define data in a Linear Algebra Matrix
    X = Matrix(convert(Array{Float64}, data ))
    return X
end