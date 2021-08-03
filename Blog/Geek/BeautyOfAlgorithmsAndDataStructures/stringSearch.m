//
//  String.m
//  Blog
//
//  Created by Mirinda on 2019/8/9.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "stringSearch.h"

@implementation stringSearch
static int modelHash[26]= {-1};
//abadcsjdsgdacccadasdcccjcdasjkabcbc
//           cccadasdccc
- (void)strInto {
  printf("BM index = %ld\n",searchStringWithBM("bsjsnsakmawmsacccadcccasdcccsakkakkaskda","kkak"));
  printf("KMP index = %d\n",KMPString("bsjsnsakmawmsacccadcccasdcccsakkakkaskda","kkak"));
}

//BM(Boyer-Moore)算法,查找字符串
long searchStringWithBM(char *str, char *model) {
  long SLen = strlen(str);
  long MLen = strlen(model);
  int suffix[16] = {-1};
  bool preSuffix[16] = {false};
  memset(suffix, -1, 16*sizeof(int));
  memset(preSuffix, false, 16*sizeof(bool));
  buildModelHash(model);
  modelStrigOperation(model,suffix,preSuffix,MLen);
  
  long flag = MLen-1;
  while (flag < SLen) {
    long j = 0, k = flag;
    for (j = MLen-1; j>=0; j--) {
      if (str[k] != model[j]) break;
      k--;
    }
    long interval = -1;
    if (-1 == j) {
      return flag - MLen + 1;
    }
    if (j < MLen-1) interval = goodSuffixMatch(model,(int)MLen, (int)j, suffix, preSuffix);
    long position = searchBadCharPosition(str[k]);
    if (-1 == position) position = MLen;
    else position =j-position;
    
    interval = interval > position ? interval : position;
    flag = flag + interval;
  }
  return -1;
}

//查找坏字符的散列矩阵
void buildModelHash(char* model) {
  memset(modelHash, -1, 26*sizeof(int));
  long len = strlen(model);
  for (int i = 0; i < len; i++) {
    int p = model[i] - 'a';
    modelHash[p] = i;
  }
}

int searchBadCharPosition(char c) {
  return modelHash[c - 'a'];
}



//模式串自处理
void modelStrigOperation(char *model, int *suffix, bool *preSuffix, long len) {
  if (0 == len) return;
  memset(suffix, -1, 16*sizeof(int));
  memset(preSuffix, false, 16*sizeof(int));
  
  for (int i= 0 ; i < len-1; i++) {
    int j = i;
    int k = 0;
    while (j>=0 && model[j] == model[len-1-k]) {
      j--;
      k++;
      suffix[k] =j+1;
    }
    
    if (-1 == j) preSuffix[k] = true;
  }
}

int goodSuffixMatch(char *model, int len, int badCharPosition, int *suffix, bool *preSuffix) {
  //获取好后缀的长度
  int k = len - 1 - badCharPosition;
  if (suffix[k] != -1) return badCharPosition+1-suffix[k];
  for (int j = badCharPosition+2; j<=len-1; j++) {
    if (preSuffix[len-j] == true) {
      return j;
    }
  }
  return len;
}

//KMP
int KMPString(char *str,  char *model) {
  long SLen = strlen(str);
  long MLen = strlen(model);
  int next[16] = {-1};
  modelOperateSelf(model, next, 16);
  int j = 0;
  for (int i = 0; i<SLen; i++) {
    while (j > 0 && model[j] != str[i]) {
      j = next[j-1]+1;
    }
    
    if (model[j] == str[i]) {
      j++;
    }
    
    if (j == MLen) {
      return i-MLen+1;
    }
  }
  return -1;
}

int* modelOperateSelf(char* model, int *next, int nextLen) {
  long len = strlen(model);
  memset(next, -1, nextLen*sizeof(int));
  
  int k = -1;
  for (int i = 1; i < len-1; i++) {
    while(-1 != k && model[k+1] != model[i]) {
      k = next[k];
    }
    
    if (model[k+1] == model[i]) {
      k++;
    }
    
    next[i] = k;
  }
  
  return next;
}
@end

