from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def __init__(self):
        self.front_pointer = None
        self.logs = []  # 存储状态日志

    def log_state(self, variables):
        """记录状态"""
        state = {var: str(val.val if isinstance(val, ListNode) else val)
                 for var, val in variables.items()}
        self.logs.append(state)

    def isPalindrome(self, head: ListNode) -> bool:
        self.front_pointer = head

        def recursively_check(current_node=head):
            if current_node is not None:
                self.log_state({"currentNode": current_node, "front_pointer": self.front_pointer})
                if not recursively_check(current_node.next):
                    return False
                self.log_state({"currentNode": current_node, "front_pointer": self.front_pointer})
                if self.front_pointer.val != current_node.val:
                    return False
                self.front_pointer = self.front_pointer.next
            return True

        return recursively_check()

@app.route('/execute', methods=['POST'])
def execute():
    try:
        data = request.json
        values = data.get("values", [])
        if not values:
            return jsonify({"error": "No values provided"}), 400

        # 构建链表
        head = ListNode(values[0])
        current = head
        for val in values[1:]:
            current.next = ListNode(val)
            current = current.next

        solution = Solution()
        result = solution.isPalindrome(head)

        return jsonify({
            "result": result,
            "logs": solution.logs  # logs 是一个数组
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
