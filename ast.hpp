#ifndef AST_HPP
#define AST_HPP

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <memory>

extern std::map<std::string, int> variables;
extern std::map<std::string, std::string> string_vars;

class ASTNode {
public:
    virtual ~ASTNode() {}
    virtual void evaluate() = 0;
};

class StatementListNode : public ASTNode {
    std::vector<std::unique_ptr<ASTNode>> statements;
public:
    void add(ASTNode* stmt);
    void evaluate() override;
};

class ExpressionNode {
public:
    virtual ~ExpressionNode() {}
    virtual int evaluate() = 0;
    virtual std::string getStringValue() const { return ""; }  // <- nuevo para impresión string
    virtual std::string getName() const { return ""; }
};

class NumberNode : public ExpressionNode {
    int value;
public:
    NumberNode(int val) : value(val) {}
    int evaluate() override;
};

class VariableNode : public ExpressionNode {
    std::string name;
    bool isString;
public:
    VariableNode(const std::string& name, bool isStr) : name(name), isString(isStr) {}
    
    int evaluate() override {
        return isString ? 0 : variables[name];
    }

    std::string getStringValue() const override {
        if (isString && string_vars.count(name)) {
            return string_vars.at(name);
        }
        return "";
    }
};



class BinaryOpNode : public ExpressionNode {
    std::string op;
    std::unique_ptr<ExpressionNode> left, right;
public:
    BinaryOpNode(const std::string& op, ExpressionNode* l, ExpressionNode* r);
    int evaluate() override;
};

class DeclarationNode : public ASTNode {
    std::string name;
public:
    DeclarationNode(const std::string& name) : name(name) {}
    void evaluate() override;
};

class AssignmentNode : public ASTNode {
    std::string name;
    std::unique_ptr<ExpressionNode> expr;
public:
    AssignmentNode(const std::string& name, ExpressionNode* expr);
    void evaluate() override;
};

class PrintNode : public ASTNode {
    std::unique_ptr<ExpressionNode> expr;
public:
    PrintNode(ExpressionNode* expr);
    void evaluate() override;
};

class IfElseNode : public ASTNode {
    std::unique_ptr<ExpressionNode> cond;
    std::unique_ptr<ASTNode> ifBlock;
    std::unique_ptr<ASTNode> elseBlock;
public:
    IfElseNode(ExpressionNode* cond, ASTNode* ifBlock, ASTNode* elseBlock);
    void evaluate() override;
};

class WhileNode : public ASTNode {
    std::unique_ptr<ExpressionNode> cond;
    std::unique_ptr<ASTNode> block;
public:
    WhileNode(ExpressionNode* cond, ASTNode* block);
    void evaluate() override;
};

class InputNode : public ASTNode {
    std::string name;
public:
    InputNode(const std::string& name) : name(name) {}
    void evaluate() override {
        std::cout << "Ingresa valor para " << name << ": ";
        std::cin >> variables[name];
    }
};


class DeclareStringNode : public ASTNode {
    std::string name;
public:
    DeclareStringNode(const std::string& name) : name(name) {}
    void evaluate() override {
        string_vars[name] = "";
    }
};

class AssignStringNode : public ASTNode {
    std::string name;
    std::string value;
public:
    AssignStringNode(const std::string& name, const std::string& val)
        : name(name), value(val) {}

    void evaluate() override {
        string_vars[name] = value;
    }
};


class StringNode : public ExpressionNode {
    std::string value;
public:
    StringNode(const std::string& val) : value(val) {}
    int evaluate() override { return 0; }
    std::string getStringValue() const override { return value; }
};


#endif