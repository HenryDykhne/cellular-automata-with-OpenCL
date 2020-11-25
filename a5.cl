//Name: Eli-Henry Dykhne
//Student Number: 0996524
bool rule30(char a, char b, char c) {
    bool alive = false;
    if((a != ' ' && b == ' ' && c == ' ') || (a == ' ' && b != ' ' && c != ' ') || (a == ' ' && b != ' ' && c == ' ') || (a == ' ' && b == ' ' && c != ' ')) {
        alive = true;
    }
    return alive;
}


__kernel void a5(__global char* twoDimensionalArray, __local char* localLine, __local char* localNewLine, int sideLength, int numKernels) {
    //calculate kernels section with offsets
    //determine start and end of section to process
    int myGlobalRank = get_global_id(0);
    int localCellCount = ceil((double) sideLength / numKernels); 
    int firstCell = myGlobalRank * localCellCount;
    int lastCell = (myGlobalRank + 1) * localCellCount - 1;

    //dealing with non cleanly dividing amounts of points/threads
    if(lastCell >= sideLength){
        lastCell = sideLength - 1;
    }

    int lengthOfResult = lastCell - firstCell + 1;
    
    for(int i = 1; i < sideLength; i++) {
        //copy local section in
        for(int j = 0; j < lengthOfResult; j++) {
            localLine[j + firstCell] = twoDimensionalArray[j + (sideLength * (i - 1)) + firstCell];
        }
        barrier(CLK_LOCAL_MEM_FENCE);

        for(int j = 0; j < lengthOfResult; j++) {
            //calculate each cell in section and copy into localNewLine
            char a, b, c;
            if(j - 1 + firstCell < 0) {
                a = ' ';
            } else {
                a = localLine[j - 1 + firstCell];
            }
            b = localLine[j + firstCell];
            if(j + 1 + firstCell >= sideLength) {
                c = ' ';
            } else {
                c = localLine[j + 1 + firstCell];
            }

            if(rule30(a, b, c)) {
                localNewLine[j + firstCell] = myGlobalRank + '0';
            } else {
                localNewLine[j + firstCell] = ' ';
            }
        }

        //copy kernels section into global twoDimensionalArray
        for(int j = 0; j < lengthOfResult; j++) {
            twoDimensionalArray[j + (sideLength * i) + firstCell] = localNewLine[j + firstCell];
        }
        barrier(CLK_LOCAL_MEM_FENCE);
    }
}
