//
//  ListSum.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 5/8/25.
//

struct ListNode {
      int val;
      ListNode *next;
      ListNode() : val(0), next(nullptr) {}
      ListNode(int x) : val(x), next(nullptr) {}
      ListNode(int x, ListNode *next) : val(x), next(next) {}
};

uint64_t recursive_list_to_i(ListNode *list, uint64_t place)
{
    if (list->next == nullptr) {
        return list->val * place;
    }
    return ((list->val) * place) + recursive_list_to_i(list->next, place*10);
}

uint64_t list_to_i(ListNode *list) {
    return recursive_list_to_i(list, 1);
}

ListNode* recursive_i_to_list(uint64_t dividend) {
    const uint64_t divisor = 10;
    if (divisor > dividend) {
        ListNode* node = new ListNode((int)dividend);
        return node;
    }
    uint64_t quotient = dividend / divisor;
    uint64_t remainder = dividend % divisor;
    ListNode* node = new ListNode((int)remainder);
    node->next = recursive_i_to_list(quotient);
    return node;
}

ListNode* i_to_list(uint64_t value) {
    return recursive_i_to_list(value);
}

ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
    if (l1 == nullptr || l2 == nullptr) {
        return nullptr;
    }
    uint64_t sum = list_to_i(l1) + list_to_i(l2);
    ListNode* sumList = i_to_list(sum);
    return sumList;
}
