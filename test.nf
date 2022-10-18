

channel
    .from('Hello','Hola','Ciao')
    .set{ cheers }

cheers
    .map{ it.toUpperCase() }
    .view()

cheers
    .map{ it.reverse() }
    .view()



// params.greeting = "hello"
// params.mynums = [1, 2, 3, 4, 5]

// creation:
// fromPath (single or list of files)
// of  (single val)
// fromList (list of vals)

// ch_myfile = Channel.fromPath("./nf-workflows/airrflow/main.nf.gz")
// ch_myfilesnull = Channel.fromList(["./notes.txt", "./questions.txt", null])
// ch_myfilesarr = Channel.fromList(["./notes.txt", "./questions.txt"]).collect()


// cutadapt -a <adapterseq> raw.fq > trimmed.fq

// ch_adapters = Channel.of('AGGTATA')



// process PATHSTEST {
//     input:
//       path positional
//       path mandatoryOption
//       path optionalOption
//       path optionalBoolean

//     output:
//       stdout emit: outstr

//     script:
//     """
//     echo -in ${infile}
//     """
// }

// process OPTIONALOPT {
//     input:
//       path infile

//     output:
//       stdout emit: outstr

//     script:
//     def opt = infile ? "-in ${infile}" : "" 
//     """
//     echo ${opt}
//     """
// }


// workflow {
//     PATHSTEST(
//         ch_myfile,
//     ).view{ it }
// }



// process ARRAYVALS {
//     input:
//       val nums
//       path txtfiles

//     output:
//       stdout emit: outstr

//     script:
//     def nums = nums.findAll{ it % 2 == 0 }.collect{ it**2 }
//     // def mandatoryOpt = txtfiles ? "-a $params.algoType" : ""
//     // def optionalOpt = params.algoType ? "-a $params.algoType" : ""
//     """
//     echo ${nums}
//     """
// }

// process SIMPLENAME {
//     input:
//         file y

//     output:
//         stdout emit: outstr

//     script:
//     """
//     echo ""
//     echo "full name: $y"
//     echo "baseName: $y.baseName"
//     echo "simpleName: $y.simpleName"
//     """
// }

// process VARFORMAT {
//     input:
//         file y

//     output:
//         stdout emit: outstr

//     script:
//     """
//     echo $y.baseName
//     echo ${y.baseName}
//     echo $params.greeting
//     echo ${params.greeting}
//     """
// }

// process INDICES {
//     input:
//         file y

//     output:
//         stdout emit: outstr

//     script:
//     """
//     echo ${y[0]}
//     """
// }

// workflow subworkflow {
//     take: message
//     main:
//         CAPITALISE(message)
//     emit:
//         CAPITALISE.out.outstr
// }