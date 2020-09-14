# technical_assessment
Excercise 2 -> script findResistant

  to run in command line
  
    ./findResistant ariba_amr_output.csv ncbi_acquired_genes_metadata.csv
  
#INPUT:

        [1] -> ariba summary file (CSV)
        
        [2] -> ncbi acquired genes metadata (CSV)
        
#OUTPUT:

        #resistant_samples.csv -> the sample identifiers for which resistance was found
        
        #criteria_samples.csv -> values of 1 indicate all three criteria for resistance were found for a given ARIBA output cluster

-------------------------

Excercise 3 -> Nextflow 
  main.nf
