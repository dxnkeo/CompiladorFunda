#include "ast.hpp"
#include <iostream>

// ---------------- ASTNode Implementaciones ----------------

void StatementListNode::add(ASTNode* stmt) {
    statements.emplace_back(stmt);
}

void StatementListNode::evaluate() {
    for (auto& stmt : statements) {
        stmt->evaluate();
    }
}

// ---------------- ExpressionNode Implementaciones ----------------

int NumberNode::evaluate() {
    return value;
}



BinaryOpNode::BinaryOpNode(const std::string& op, ExpressionNode* l, ExpressionNode* r)
    : op(op), left(l), right(r) {}

int BinaryOpNode::evaluate() {
    int lval = left->evaluate();
    int rval = right->evaluate();

    if (op == "+") return lval + rval;
    if (op == "-") return lval - rval;
    if (op == "*") return lval * rval;
    if (op == "/") return rval != 0 ? lval / rval : 0;
    if (op == "==") return lval == rval;
    if (op == "!=") return lval != rval;
    if (op == "<")  return lval < rval;
    if (op == "<=") return lval <= rval;
    if (op == ">")  return lval > rval;
    if (op == ">=") return lval >= rval;

    return 0;
}

// ---------------- StatementNode Implementaciones ----------------

void DeclarationNode::evaluate() {
    variables[name] = 0;
}

AssignmentNode::AssignmentNode(const std::string& name, ExpressionNode* expr)
    : name(name), expr(expr) {}

void AssignmentNode::evaluate() {
    if (auto strExpr = dynamic_cast<StringNode*>(expr.get())) {
        string_vars[name] = strExpr->getStringValue();
    } else {
        variables[name] = expr->evaluate();
    }
}


PrintNode::PrintNode(ExpressionNode* expr) : expr(expr) {}

IfElseNode::IfElseNode(ExpressionNode* cond, ASTNode* ifBlock, ASTNode* elseBlock)
    : cond(cond), ifBlock(ifBlock), elseBlock(elseBlock) {}

void IfElseNode::evaluate() {
    if (cond->evaluate()) {
        ifBlock->evaluate();
    } else if (elseBlock) {
        elseBlock->evaluate();
    }
}

WhileNode::WhileNode(ExpressionNode* cond, ASTNode* block)
    : cond(cond), block(block) {}

void WhileNode::evaluate() {
    while (cond->evaluate()) {
        block->evaluate();
    }
}


void PrintNode::evaluate() {
    std::string str = expr->getStringValue();
    if (!str.empty()) {
        std::cout << str << std::endl;
    } else {
        std::cout << expr->evaluate() << std::endl;
    }
}

