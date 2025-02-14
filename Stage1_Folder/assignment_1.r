## Assignment 1
# install.packages("BiocManager")
# BiocManager::install("Biostrings")
library(Biostrings)
# Load the necessary library
library(Biostrings)
# Define the function
dna1 <- function(DNAstring) {
  # Create the DNA sequence object
  dna_seq <- DNAString(DNAstring)
  # Translate the DNA sequence into protein
  protein <- Biostrings::translate(dna_seq,genetic.code=GENETIC_CODE, if.fuzzy.codon="error")
  # Return the protein sequence
  return(protein)
}
# Call the function
dna1("ATGGCCATTGTAATGGGCCGCTGAAAGGGTGCCCGATAG")
