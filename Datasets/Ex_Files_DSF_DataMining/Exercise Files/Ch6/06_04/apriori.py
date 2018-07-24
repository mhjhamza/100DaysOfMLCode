import operator
import collections
import itertools as it


def get_all_subcombinations(item):
    subcombinations = [it.combinations(item, i + 1) for i, a in enumerate(item)]
    return [frozenset(subitem) for subcombination in subcombinations for subitem in subcombination]


def get_items_with_support_higher_then_min_and_item_frequency(items, transactions, min_support):
        item_frequency = collections.defaultdict(int)
        for item in items:
            for transaction in transactions:
                if item.issubset(transaction):
                    item_frequency[item] += 1

        support_items = [item for item in item_frequency.keys()
                         if calc_support(item, item_frequency, transactions) > min_support]
        return support_items, item_frequency


def calc_support(item, item_frequency, transactions):
    return float(item_frequency[item]) / len(transactions)


def get_items_union(items, k):
    return set([i.union(j) for i in items for j in items if len(i.union(j)) == k])


def run_apriori(file_name, min_support=0.05, min_confidence=0.2):
    transactions = read_transactions(file_name)
    items = set([frozenset([item]) for transaction in transactions for item in transaction])

    item_frequency = {}
    support_items, item_frequency_1 = get_items_with_support_higher_then_min_and_item_frequency(items, transactions,
                                                                                                min_support)
    item_frequency.update(item_frequency_1)

    k = 2
    large_set = {}
    current_items_set = support_items
    while current_items_set:
        large_set[k-1] = current_items_set
        current_items_set = get_items_union(current_items_set, k)
        current_items_set, item_frequency_k = \
            get_items_with_support_higher_then_min_and_item_frequency(current_items_set, transactions, min_support)
        item_frequency.update(item_frequency_k)
        k += 1

    item_supports = {item: calc_support(item, item_frequency, transactions) for items_set in large_set.values()
                     for item in items_set}
    rules = {}
    for k, items_set in large_set.items():
        if k > 1:
            for item in items_set:
                subcombinations = get_all_subcombinations(item)
                for subcombination in subcombinations:
                    remain = item.difference(subcombination)
                    if remain:
                        confidence = calc_support(item, item_frequency, transactions) / \
                                     calc_support(subcombination, item_frequency, transactions)
                        if confidence >= min_confidence:
                            rules[(subcombination, remain)] = confidence

    item_supports = sorted(item_supports.items(), key=operator.itemgetter(1), reverse=True)
    rules = sorted(rules.items(), key=operator.itemgetter(1), reverse=True)
    return item_supports, rules


def read_transactions(file_name):
    with open(file_name, 'r') as f:
        transactions = list(map(lambda x: set(x.strip().split(",")), f.read().strip().split("\n")))
    return transactions


if __name__ == "__main__":
    item_supports, rules = run_apriori("groceries.csv")

