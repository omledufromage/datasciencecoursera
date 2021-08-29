cachemean <- function(x, ...) {
        m <- x$getmean()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- mean(data, ...)
        x$setmean(m)
        m
}


### The following function calculates the mean of the special *vector*  created 
### with the above function. However, it first checks to see if the mean has already 
### been calculated. If so, it gets the mean from the cache and skips the computation. 
### Otherwise, it calculates the mean of the data and sets the value of the mean in 
### the cache via the setmean function."""

### Assignment: Caching the Inverse of a Matrix 

### Matrix inversion is usually a costly computation and there may be some benefit to 
### caching the inverse of a matrix rather than compute it repeatedly (there are also 
### alternatives to matrix inversion that we will not discuss here). Your assignment 
### is to write a pair of functions that cache the inverse of a matrix.

### Write the following functions:

### makeCacheMatrix: This function creates a special *matrix* object that can cache its inverse.
### cacheSolve: This function computes the inverse of the special *matrix* returned by makeCacheMatrix 
### above. If the inverse has already been calculated (and the matrix has not changed), then the cachesolve 
### should retrieve the inverse from the cache.
### Computing the inverse of a square matrix can be done with the solve function in R. For example, if X 
### is a square invertible matrix, then solve(X) returns its inverse.

### For this assignment, assume that the matrix supplied is always invertible.

### In order to complete this assignment, you must do the following:

### Fork the GitHub repository containing the stub R files at https://github.com/rdpeng/ProgrammingAssignment2 to 
### create a copy under your own account.
### Clone your forked GitHub repository to your computer so that you can edit the files locally on your own machine.
### Edit the R file contained in the git repository and place your solution in that file (please do not rename the file).
### Commit your completed R file into YOUR git repository and push your git branch to the GitHub repository under your account.
### Submit to Coursera the URL to your GitHub repository that contains the completed R code for the assignment.
### In addition to submitting the URL for your GitHub repository, you will need to submit the 40 character SHA-1 hash 
### (as string of numbers from 0-9 and letters from a-f) that identifies the repository commit that contains the version 
### of the files you want to submit. You can do this in GitHub by doing the following

### Going to your GitHub repository web page for this assignment
### Click on the “?? commits” link where ?? is the number of commits you have in the repository. For example, if you made a 
### total of 10 commits to this repository, the link should say *10 commits*.
### You will see a list of commits that you have made to this repository. The most recent commit is at the very top. If this 
### represents the version of the files you want to submit, then just click the “copy to clipboard” button on the right hand 
### side that should appear when you hover over the SHA-1 hash. Paste this SHA-1 hash into the course web site when you submit 
### your assignment. If you don't want to use the most recent commit, then go down and find the commit you want and copy the SHA-1 hash.
### A valid submission will look something like (this is just an example!)