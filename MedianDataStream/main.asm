TITLE Find Median from Running Data Stream using Insertion Sort
;https://www.geeksforgeeks.org/median-of-stream-of-integers-running-integers/?ref=header_search
INCLUDE Irvine32.inc


.data
array SDWORD  5, 15, 1, 3, 2, 8, 7, 9, 10, 6, 11, 4
n = ($ - array) / 4
message1 BYTE "Median after reading 1",0
message2 BYTE " element is ",0
message3 BYTE "Median after reading ",0
.code
binarySearch PROC
;prologue
push ebp
mov ebp, esp
push edx
push esi
push edi
push ebx
push ecx

;if (low >= high) {
;    return (item > arr[low]) ? (low + 1) : low;
;}







;epilogue
pop ecx
pop ebx
pop edi
pop esi
pop edx
mov esp, ebp
pop ebp
ret 16
binarySearch ENDP
printMedian PROC
;prologue
push ebp
mov ebp, esp
sub esp,8 ; allocate space for local variables : num
          ; num : esp-4 ,count : esp-8
push edx
push esi
push edi
push ebx
push ecx

;initialization
mov [ebp-8],DWORD ptr 1 ; count = 1;

;body
; Print message to screen
mov edx, OFFSET message1
call WriteString
mov edx, OFFSET message2
call WriteString
mov edx, [ebp + 8]
call WriteDec
call crlf

; for (i = 1; i < n; i++) {
  ;initialization
  mov esi,1    ;esi= i = 1;

  ;body
forloop:
  mov edi,esi
  dec edi		  ; j = i - 1;

  mov ebx,[ebp+8] ; ebx = array[];
  lea ebx,[ebx+esi*4] ; ebx = &array[i];
  mov eax,[ebx]    ; eax = arr[i];
  mov [ebp-4],eax ; num = arr[i]==eax;


  push edi
  push DWORD ptr 0h
  push [ebp-4]
  push [ebp+8]
  call binarySearch ;pos = binarySearch(arr, num, 0, j);
  ; binarySearch(arr, num, 0, j) returns pos to eax

  ;while (j >= pos) {
  ;initialization

  ;body
whileloop:     
   mov ebx,[ebp+8] ; ebx = array[];
   lea ebx,[ebx+edi*4] ; ebx = &array[j];
   mov eax,[ebx]    ; eax = arr[j];
   mov [ebx+4],eax ; arr[j+1] = arr[j];
  ;step
   dec edi
  ;finalization
   cmp edi,eax
   jge whileloop
  ; end while loop

   ;arr[j + 1] = num;
   mov ecx,[ebp-4]
   mov ebx,[ebp+8] ; ebx = array[];
   lea ebx,[ebx+edi*4] ; ebx = &array[j];
   mov [ebx+4], ecx ; arr[j+1] = num;

   ;count++;
   inc SDWORD PTR [ebp-8]

   ; count % 2 odd or even ??? check
   mov eax,[ebp-8] ; eax = count
   mov edx,00000001h
   and eax,edx ; eax = count % 2


   ;if (count % 2 != 0) {
   cmp eax,0
   je evennumber
oddnumber:
   ;if body
   ;median = arr[count / 2];
   mov eax,[ebp-8] ; eax = count
   shr eax,1 ; eax = count / 2
   mov ebx,[ebp+8] ; ebx = array[];
   lea ebx,[ebx+eax*4] ; ebx = &array[count/2];
   mov eax,[ebx] ; eax = arr[count/2];
   jmp exitif
evennumber:
   ;else body
   ;median = (arr[(count / 2) - 1] + arr[count / 2])/ 2;
   mov ebx,[ebp-8] ; ebx = count
   shr ebx,1 ; ebx = count / 2
   dec ebx ; ebx = count / 2 - 1

   mov edx,[ebp+8] ; edx = array[];
   lea edx,[edx+ebx*4] ; edx = &array[count/2 - 1];
   mov edx,[edx] ; edx = arr[count/2 - 1];

   mov ebx,[ebp-8] ; ebx = count
   shr ebx,1 ; ebx = count / 2

   mov eax,[ebp+8] ; edx = array[];
   lea eax,[eax+ebx*4] ; edx = &array[count/2 - 1];
   mov eax,[eax] ; edx = arr[count/2 - 1];

   add eax,edx ; eax = arr[count/2 - 1] + arr[count/2];
   shr eax,1 ; eax = (arr[count/2 - 1] + arr[count/2])/ 2;
   mov edx,eax ; save median in edx
exitif:

   ; Print message to screen
   mov edx, OFFSET message3
   call WriteString
  
   ; print i+1
   mov eax,esi
   add eax,1
   call WriteDec


   mov edx, OFFSET message2
   call WriteString
   
   ; print median
   mov eax,edx
   call WriteDec
   call crlf

  ;step
  inc esi
  ;check
  cmp esi,[ebp+12] ;i < n;
  jl forLoop


; end for loop



;epilogue
pop ecx
pop ebx   
pop edi
pop esi
pop edx
mov esp, ebp
pop ebp
ret	8
printMedian ENDP
main PROC

push n			  
push OFFSET array
call printMedian

exit
main ENDP
END main



