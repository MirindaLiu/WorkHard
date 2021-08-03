//
//  Link.m
//  Blog
//
//  Created by Mirinda on 2019/7/1.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "Link.h"


@implementation Link
- (void)linkInto {
    linkNode *p =  creatLink();
//    linkReversal2(p);
//    linkNode *p1 = creatLinkHaveCircle();
//    isLinkHaveAcircle(p);
//    linkNode *p1 = creatLinkBase(false, true);
//    linkNode *p2 = creatLinkBase(true, true);
//    mergeTwoOrderedLink(p1, p2);
//    deleteNode(p, 7);
//    getMiddleNode(p);
    getMiddleNode2(p);
}
linkNode* creatLink(){
    return creatLinkBase(false, false);
}

//第一个参数是否控制创建奇数链表, 第二个参数是控制数之间的间隔是否是2
linkNode* creatLinkBase(bool even, bool interval2 ) {
    linkNode *head = NULL;
    head = (linkNode*)malloc(sizeof(linkNode));
    head->value = 0xFFFFFFFF;
    if (!head) {
        return NULL;
    }
    linkNode *p = head;
    
    int i = 0;
    if (even) {
        i = 1;
    }
    
    int interval = 1;
    if (interval2) {
        interval = 2;
    }
    
    for (; i< 10*interval; i=i+interval) {
        p->next = malloc(sizeof(linkNode));
        p->next->value = i;
        p = p->next;
    }
    p->next = NULL;
    
    return head;
}


linkNode* creatLinkHaveCircle() {
    linkNode *head = creatLink();
    linkNode *p = head;
    linkNode *p2 = NULL;
    int i = 0;
    while (NULL != p->next) {
        i++;
        p = p->next;
        if(i == 6) {
            p2 = p;
        }
    }
    p->next = p2;
    return head;
}


//链表翻转
linkNode* linkReversal(linkNode* link) {
    if (!link) return NULL;
    linkNode *p = link->next;//p指向第一个节点
    
    //把第p节点后面的节点一次插入到头节点的后面
    while(NULL != p->next) {
        //第一步:取出p节点(原来的第一个节点)的下一个节点
        linkNode *pNext = p->next;
        p->next = p->next->next;
        
        //第二步:把取出来的节点插入到头结点后面
        linkNode *linkNext = link->next;
        link->next = pNext;
        pNext->next = linkNext;
    }
    
    return link;
}

//链表翻转2
linkNode* linkReversal2(linkNode* link) {
    if (!link) return NULL;
    linkNode *p = link->next;//p指向第一个节点
    linkNode *p2 = p->next;
    p->next = NULL;
    
    while(NULL != p2) {
        linkNode *temp = p;
        p = p2;
        p2 = p2->next;
        p->next = temp;
    }
    link->next = p;
    return link;
}




bool isLinkHaveAcircle(linkNode* link) {
    
    if(!link) return false;
    linkNode *p1 = link;
    linkNode *p2 = link;
    bool isHaveCircle = false;
    
    while (NULL != p1->next) {
        p1 = p1->next->next;
        p2 = p2->next;
        
        if (p1 == p2) {
            isHaveCircle = true;
            break;
        }
    }
    
    return isHaveCircle;
}

//合并两个有序链表
linkNode* mergeTwoOrderedLink(linkNode *h1, linkNode *h2) {
    if(!h1->next && !h2->next) return NULL;
    if(!h1->next) return h2;
    if(!h2->next) return h1;
    
    linkNode *p1 = h1;
    linkNode *p2 = h2;
    bool breakFlag = false;
    linkNode *head = (linkNode*)malloc(sizeof(linkNode));
    
    if(!head) {
        head = p1;
    }
    head->value = -1;
    linkNode *p = head;
    p1 = p1->next; // 指向第一个节点
    p2 = p2->next; // 指向第一个节点

    while (!breakFlag) {
        if(NULL == p1->next) {
            p->next = p2;
            breakFlag = true;
            break;
        }
        
        if(NULL == p2->next) {
            p->next = p1;
            breakFlag = true;
            break;
        }
        
        if (p1->value < p2->value) {
            p->next = p1;
            p1 = p1->next;
        }else {
            p->next = p2;
            p2 = p2->next;
        }
        p = p->next;
    }
    return head;
}

//删除第N个节点
void deleteNode(linkNode *link, int position) {
    if (!link) return;
    linkNode *p = link;
    for (int i = 1 ; i < position; i++) {
        p = p->next;
    }
    
    linkNode *p1 = p->next;
    p->next = p->next->next;
    free(p1);
    p1 = NULL;
}



//获取中间节点1
linkNode* getMiddleNode(linkNode* link) {
    if (!link) return NULL;
    linkNode *p = link;
    int length = 0;
    while(NULL != p->next){
        length++;
        p = p->next;
    }
    
    p = link;
    for (int i = 0; i<(length+1)/2; i++) {
        p = p->next;
    }
    
    p->next = NULL;
    return p;
}


//获取中间节点2
linkNode* getMiddleNode2(linkNode* link) {
    if (!link) return NULL;
    linkNode *fast = link;
    linkNode *slow = link;
    
    while(fast) {
        if (fast->next) {
            fast = fast->next->next;
        }else {
            break;
        }
        slow = slow->next;
    }
    
    return slow;
}

//双向链表排序


@end
