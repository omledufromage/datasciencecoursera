install.packages("BiocManager")
BiocManager::install

BiocManager::install("rhdf5")

library(rhdf5)
created <- h5createFile("example.h5")
created

# Create groups
created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa") # subgroup of foo
h5ls("example.h5") # ls command

# Write to groups
A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1,2.0, by = 0.1), dim = c(5, 2, 2))
attr(B, "scale") <- "liter" # Add metadata/units.
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

# Write a dataset
df = data.frame(1L:5L, seq(0, 1, length.out = 5), 
                c("ab", "cde", "fghi", "a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5", "df")
h5ls("example.h5")

# Read data
readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
readA
readB
readdf

# Easy to write and read in chunks
h5write(c(12,13,14), "example.h5", "foo/A", index=list(1:3,1)) #Write to the first 3 rows of the first column.
h5read("example.h5", "foo/A")
h5read("example.h5", "foo/A", index=list(1:3,1)) # same command to only read those rows and column.

# http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf
# HDF group has information no HDF5 in general http://www.hdfgroup.org/HDF5/