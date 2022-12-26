#include "unity.h"
#include "file_to_test.h"

void setUp(void) {
    // set stuff up here
}

void tearDown(void) {
    // clean stuff up here
}

void test_function_should_doBlahAndBlah(void) {
    //test stuff
}

void test_function_should_doAlsoDoBlah(void) {
    //more test stuff
}

// not needed when using generate_test_runner.rb
int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_function_should_doBlahAndBlah);
    RUN_TEST(test_function_should_doAlsoDoBlah);
    return UNITY_END();
}

/*
        TEST_ASSERT_X( {modifiers}, {expected}, actual, {size/count} )
TEST_ASSERT_X_MESSAGE( {modifiers}, {expected}, actual, {size/count}, message )

0. boolean
TEST_ASSERT_TRUE(condition)    TEST_ASSERT(condition)           计算任何处于条件下的代码，如果计算结果为false，则失败
TEST_ASSERT_FALSE(condition)   TEST_ASSERT_UNLESS(condition)    对任何处于条件下的代码求值，如果求值为true，则失败

TEST_FAIL()                                                     这个测试被自动标记为失败。
TEST_FAIL_MESSAGE(message)                                      消息输出说明了原因。

1. Numerical Assertions: Integers
比较两个整数是否相等，并将错误显示为带符号的整数。强制类型转换将按您的自然整数大小执行，因此经常可以使用这种方法。当你需要指定确切的大小，如比较数组时，你可以使用一个特定的版本:
TEST_ASSERT_EQUAL_INT(expected, actual)
TEST_ASSERT_EQUAL_INT8(expected, actual)
TEST_ASSERT_EQUAL_INT16(expected, actual)
TEST_ASSERT_EQUAL_INT32(expected, actual)
TEST_ASSERT_EQUAL_INT64(expected, actual)
比较两个整数是否相等，并将错误显示为无符号整数。像INT一样，也有不同大小的变体。
TEST_ASSERT_EQUAL_UINT(expected, actual)
TEST_ASSERT_EQUAL_UINT8(expected, actual)
TEST_ASSERT_EQUAL_UINT16(expected, actual)
TEST_ASSERT_EQUAL_UINT32(expected, actual)
TEST_ASSERT_EQUAL_UINT64(expected, actual)
比较两个整数是否相等，并将错误显示为十六进制。
TEST_ASSERT_EQUAL_HEX(expected, actual)
TEST_ASSERT_EQUAL_HEX8(expected, actual)
TEST_ASSERT_EQUAL_HEX16(expected, actual)
TEST_ASSERT_EQUAL_HEX32(expected, actual)
TEST_ASSERT_EQUAL_HEX64(expected, actual)

1.1 区间 INT/UINT/HEX/CHAR
TEST_ASSERT_EQUAL(expected, actual)              # 另一种调用TEST_ASSERT_EQUAL_INT的方法
TEST_ASSERT_INT_WITHIN(delta, expected, actual)  # 断言实际值在期望值的正负之间

1.2 大于小于 INT
TEST_ASSERT_GREATER_THAN(threshold, actual)      # 断言实际值大于阈值
TEST_ASSERT_LESS_THAN(threshold, actual)         # 断言实际值小于阈值
TEST_ASSERT_GREATER_THAN_INT8 (threshold, actual)
TEST_ASSERT_GREATER_OR_EQUAL_INT16 (threshold, actual)
TEST_ASSERT_LESS_THAN_INT32 (threshold, actual)
TEST_ASSERT_LESS_OR_EQUAL_UINT (threshold, actual)
TEST_ASSERT_NOT_EQUAL_UINT8 (threshold, actual)

1.3 数组 INT/UINT/HEX/CHAR/PTR/STRING/MEMORY
您可以将_ARRAY附加到任何这些宏中，以对该类型进行数组比较。在这里，您需要更关心被检查的值的实际大小。您还将指定一个附加参数，即要比较的元素数量
TEST_ASSERT_EQUAL_HEX8_ARRAY(expected, actual, elements)  # 数组比较
另一个数组比较选项是检查数组中的每个元素是否等于单个期望值。您可以通过指定EACH_EQUAL宏来实现这一点
TEST_ASSERT_EACH_EQUAL_INT32(expected, actual, elements)  # 数组-单值

TEST_ASSERT_EQUAL_INT_ARRAY (expected, actual, num_elements)
TEST_ASSERT_EQUAL_INT8_ARRAY (expected, actual, num_elements)
TEST_ASSERT_EQUAL_INT16_ARRAY (expected, actual, num_elements)
TEST_ASSERT_EQUAL_INT32_ARRAY (expected, actual, num_elements)
TEST_ASSERT_EQUAL_INT64_ARRAY (expected, actual, num_elements)

1.4 字符
TEST_ASSERT_EQUAL_CHAR (expected, actual)

2. bitwise
TEST_ASSERT_BITS(mask, expected, actual)         # 仅比较 和 参数的屏蔽位
TEST_ASSERT_BITS_HIGH(mask, actual)              # 断言参数的屏蔽位为高位
TEST_ASSERT_BITS_LOW(mask, actual)               # 断言参数的屏蔽位为低位
TEST_ASSERT_BIT_HIGH(bit, actual)                # 断言参数的指定位为高位
TEST_ASSERT_BIT_LOW(bit, actual)                 # 断言参数的指定位为低

3. float/double
TEST_ASSERT_FLOAT_WITHIN(delta, expected, actual) # 断言实际值在期望值的正负之间。
TEST_ASSERT_EQUAL_FLOAT(expected, actual)         # 断言两个浮点值在期望值的小%增量内“相等”
TEST_ASSERT_EQUAL_DOUBLE(expected, actual)        # 断言两个浮点值在期望值的小%增量内“相等”

TEST_ASSERT_FLOAT_IS_INF (actual)           断言参数等效于正无穷大浮点表示。actual
TEST_ASSERT_FLOAT_IS_NEG_INF (actual)       断言参数等效于负无穷大浮点表示。actual
TEST_ASSERT_FLOAT_IS_NAN (actual)           断言该参数是"非 A 数字"浮点表示形式。actual
TEST_ASSERT_FLOAT_IS_DETERMINATE (actual)   断言 "actual" 参数是可用于数学运算的浮点表示。也就是说，该参数既不是正无穷大也不是负无穷大，也不是"非数字"浮点表示。actual
TEST_ASSERT_FLOAT_IS_NOT_INF (actual)       断言参数是正无穷大浮点表示以外的值。actual
TEST_ASSERT_FLOAT_IS_NOT_NEG_INF (actual)   断言参数是负无穷大浮点表示以外的值。actual
TEST_ASSERT_FLOAT_IS_NOT_NAN (actual)       断言该参数是非"非数字"浮点表示形式的值。actual
TEST_ASSERT_FLOAT_IS_NOT_DETERMINATE (actual)

4. string
TEST_ASSERT_EQUAL_STRING(expected, actual)                              # 比较两个空终止字符串。如果任何字符不同或长度不同，则失败。
TEST_ASSERT_EQUAL_STRING_LEN(expected, actual, len)                     # 比较两个字符串。如果任何字符不同，则在len字符后停止比较。
TEST_ASSERT_EQUAL_STRING_MESSAGE(expected, actual, message)             # 比较两个空终止字符串。如果任何字符不同或长度不同，则失败。失败时输出自定义消息。
TEST_ASSERT_EQUAL_STRING_LEN_MESSAGE(expected, actual, len, message)    # 比较两个字符串。如果任何字符不同，则在len字符后停止比较。失败时输出自定义消息。

5. pointer
Pointer Assertions
大多数指针操作都可以通过使用上面的整数比较来执行。但是，为了清楚起见，添加了一些特殊的情况。
TEST_ASSERT_NULL(pointer)       如果指针不等于NULL，则失败
TEST_ASSERT_NOT_NULL(pointer)   如果指针等于NULL，则失败
TEST_ASSERT_EMPTY (pointer)
TEST_ASSERT_NOT_EMPTY (pointer)

6. memory
Memory Assertions
TEST_ASSERT_EQUAL_MEMORY(expected, actual, len) # 比较两块内存。
*/