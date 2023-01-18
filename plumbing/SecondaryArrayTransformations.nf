
nextflow.enable.dsl=2

ch_bambais1 = Channel.of(
    ['sample1', 'bam1', 'bai1'],
    ['sample2', 'bam2', 'bai2'],
    ['sample3', 'bam3', 'bai3'],
)
ch_bambais2 = Channel.of(
    ['sample1', ['bam1', 'bai1']],
    ['sample2', ['bam2', 'bai2']],
    ['sample3', ['bam3', 'bai3']],
)
ch_bambais3 = Channel.of(
    ['sample1', [['bam1'], 'bai1']],
    ['sample2', [['bam2'], 'bai2']],
    ['sample3', [['bam3'], 'bai3']],
)
ch_bambais4 = Channel.of(
    ['sample1', 'bam1'],
    ['sample1', 'bai1'],
    ['sample2', 'bam2'],
    ['sample2', 'bai2'],
    ['sample3', 'bam3'],
    ['sample3', 'bai3'],
)


/*
collect()
- removes one layer of nesting for items in channel.
- output is an array as sole emission.
*/
// ch_bambais1.collect().view{ 'collect1(): ' + it }
// ch_bambais2.collect().view{ 'collect2(): ' + it }
// ch_bambais3.collect().view{ 'collect3(): ' + it }
// ch_bambais4.collect().view{ 'collect4(): ' + it }


/*
flatten()
- removes all nesting for items in channel.
- items are emitted independently. 
*/
// ch_bambais1.flatten().view{ 'flatten1(): ' + it }
// ch_bambais2.flatten().view{ 'flatten2(): ' + it }
// ch_bambais3.flatten().view{ 'flatten3(): ' + it }
// ch_bambais4.flatten().view{ 'flatten4(): ' + it }


/*
toList(), toSortedList()
- adds a single layer of nesting to items in channel. 
- output is an array as sole emission.
- toSortedList sorts items in channel alphanumerically, or can provide closure. 
*/
// ch_bambais1.toList().view{ 'toList1(): ' + it }
// ch_bambais2.toList().view{ 'toList2(): ' + it }
// ch_bambais3.toList().view{ 'toList3(): ' + it }
// ch_bambais4.toList().view{ 'toList3(): ' + it }
// ch_bambais1.toSortedList().view{ 'toSortedList(): ' + it }
// ch_bambais1.toSortedList{ a, b -> b[1] <=> a[1] }.view{ 'toSortedListClosure(): ' + it }
// // note above: 'a' is this item, 'b' is next item. 
// // dont actually know what <=> means lol


/*
groupTuple()
- first item in each tuple used as key
- creates array output for each k:list[val] pair
- possibly useful! 
- opposite of transpose() for ch_bambais2
*/
// ch_bambais4.groupTuple().view{ 'groupTuple4(): ' + it }


/*
transpose()
- opposite of groupTuple() for ch_bambais2
*/
// ch_bambais1.transpose().view{ 'transpose1(): ' + it } // no effect
// ch_bambais2.transpose().view{ 'transpose2(): ' + it } // interesting
// ch_bambais3.transpose().view{ 'transpose3(): ' + it } // same behaviour as above (ch_bambais2)
// ch_bambais4.transpose().view{ 'transpose4(): ' + it } // no effect


/*
map()
- perform function on each item in channel
- can only return single item for each input item (1:1 mapping)
*/
// ch_bambais1.map{ ['0: ' + it[0], '1: ' + it[1], '2: ' + it[2]] }.view()


/*
multiMap()
- perform function on each item in channel
- can forward items emitted into two or more output channels (1:many mapping)
*/
// ch_bambais1.multiMap { it ->
//     samples: it[0]
//     bams: it[1]
//     bais: it[2]
// }
// .set { temp }

// temp.samples.collect().view { "samples $it" }
// temp.bams.collect().view { "bams $it" }
// temp.bais.collect().view { "bais $it" }

// ch_bambais2.multiMap { it ->
//     samples: it[0]
//     bams: it[1][0]
//     bais: it[1][1]
// }
// .set { temp }

// temp.samples.collect().view { "samples $it" }
// temp.bams.collect().view { "bams $it" }
// temp.bais.collect().view { "bais $it" }



// // multi-channel operators
// combine
// concat
// cross
// join


