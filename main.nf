#!/usr/bin/env nextflow
params.input_dir = "./fastas"
params.output_dir = "./results"
params.fasta_pattern = "*.fasta"


if (params.input_dir) {
  input_dir = params.input_dir - ~/\/$/
  output_dir = params.output_dir - ~/\/$/
  fasta_pattern = params.fasta_pattern
  fasta_files = input_dir + '/' + fasta_pattern

  Channel
    .fromPath(fasta_files)
    .ifEmpty { error "Cannot find any fastas matching: ${fasta_files}" }
    .set { fastas }
  Channel
    .fromPath(fasta_files)
    .ifEmpty {error "Cannot find any fastas matching: ${fasta_files}"}
    .set { fastas2 }
}

//seqsero
process serotyping {
   memory '1 GB'
   publishDir "${output_dir}/seqsero",
   mode:'copy', 
   saveAs: { file -> "SeqSero_result_${fasta}_dir"}
 

  input:
  file (fasta) from fastas

  output:
  file('SeqSero_result_*')

  """
  SeqSero2_package.py -m k -p 2 -t 4 -i ${fasta} 
  """
}

//SISTR
process serosistr {
	memory '1GB'
	publishDir "${output_dir}/sistr",
	mode:'copy',
	saveAs: { file -> "SISTR_result_${fasta2}"}

	input:
	file (fasta2) from fastas2

	output:
	file ('SISTR_result_*')

        """
        sistr --qc -vv \
        --alleles-output SISTR_results_allele-results_${fasta2}.json \
        --novel-alleles SISTR_results_novel-alleles_${fasta2}.fasta \
        --cgmlst-profiles SISTR_results_cgmlst-prof_${fasta2}.csv \
	-f tab \
        -o SISTR_result_${fasta2} \
        ${fasta2}
        """

}
