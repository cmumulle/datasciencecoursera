## Matrix inversion is usually a costly computation and there may be 
## some benefit to caching the inverse of a matrix rather than computing
## it repeatedly. The assignment is to write a pair of functions that 
## cache the inverse of a matrix.

## This function creates a special "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {

        inv <- NULL                     ## Initialize inv
                
        ## Define the set function (1. set the value of the vector)
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
                
        ## Define the get function (2. get the value of the vector)
        get <- function() x
                
        ## set and get the value of the inverse of the matrix
        setInverse <- function(inverse) inv <<- inverse
        getInverse <- function() inv
                
        list(set = set, get = get,
                setInverse = setInverse,
                getInverse = getInverse)
        
}

## This function computes the inverse of the special 
## "matrix" returned by makeCacheMatrix above. If the inverse 
## has already been calculated (and the matrix has not changed), 
## then the cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
        
        
        inv <- x$getInverse()
        
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        
        data <- x$get()
        
        inv <- solve(data)
        x$setInverse(inv)
        
        inv
        
}
