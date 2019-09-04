
struct FeSolver
    
    mesh::Mesh
    predict::Function
    fit::Function

end


"""
Two-dimensional CEM FE solver

    - Lagrange P1 elements for conductivity
    - Lagrange P1 elements for potential
    - Smoothness penalty for fitting

"""
function Cem2dP1Smoothness(mesh)
    
    function predict(currents, conductivity)
    
        # Build FEM system from `mesh`
        # Solve FEM system
        # Return solved potential

    end

    function fit(currents, voltages; noise_cov=nothing, alpha=.01)
        
        # Run Gauss-Newton method
        # Requires calculating Jacobian
        # Return conductivity estimate
    
    end

    return FeSolver(mesh, predict, fit)

end


"""
Two-dimensional CEM monotonicity method fitter
    
    - Lagrange P1 elements for conductivity
    - Lagrange P1 elements for potential

"""
function CEM2dP1Monotonicity(mesh)

    predict(x...) = throw(UndefRefError)
    fit(x...) = throw(UndefRefError)

end
