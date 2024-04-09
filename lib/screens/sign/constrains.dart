import 'package:share_meal/constants/constans.dart';
import 'package:flutter/material.dart';

class Constrains extends StatelessWidget {
  const Constrains({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("الشروط و الاحكام"),
        backgroundColor: green,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: white,
            )),
        titleTextStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "الشروط والاحكام",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: black, fontSize: 27, fontWeight: FontWeight.w700),
              ),
              Text(
                """
              الضمانات
        من خلال تسجيل تفاصيلك مع ShareHup كمستخدم، تضمن أن:
        أنك قادر قانونيًا على دخول عقود ملزمة؛
        أنك على الأقل في سن الثامنة عشرة؛
        المعلومات التي قدمتها لـ ShareHup صحيحة ودقيقة وصحيحة. كما تضمن أيضًا أنك ستقوم بإخطار ShareHup بسرعة في حالة حدوث أي تغيير في مثل هذه المعلومات؛ و
        أنك غير ممنوع بأي شكل من الأشكال بموجب القانون الساري في الاختصاص القضائي الذي تقع فيه حاليًا على دخول هذه الشروط لاستخدام التطبيق والخدمات.
        
        التسجيل
        لتصفح العناصر أو إتمام معاملة كطالب طلب أو مضيف داخل التطبيق، يجب عليك أولاً استكمال نموذج التسجيل وإنشاء حساب كمستخدم في ShareHup ("الحساب").
        يمكن لجميع المستخدمين المسجلين استخدام التطبيق كطالبي طلب ومضافين، ويخضعون للشروط المتعلقة بالطالبين والمضافين، حسب الاقتضاء.
        عند تسجيلك في ShareHup، سيُطلب منك الموافقة على هذه الشروط واتفاقية ترخيص المستخدم النهائي والموافقة على استخدام بياناتك الشخصية وفقًا لسياسة الخصوصية الخاصة بنا.
        قد تُمنحك ShareHup فرصة لدعوة أصدقاء عبر البريد الإلكتروني أو رسالة نصية قصيرة أو Facebook أو WhatsApp للانضمام إلى التطبيق. لا يتحمل ShareHup مسؤولية أي اتصال تقوم به عبر تطبيقات الطرف الثالث هذه، أو مواقع الويب، أو أشكال وسائل الإعلام الأخرى.
        يجب عليك الحفاظ على تفاصيل تسجيل الدخول للتطبيق ("تفاصيل تسجيل الدخول") سرية وآمنة. دون المساس بأي حقوق أو تدابير أخرى متاحة لـ ShareHup، تحتفظ ShareHup بالحق في تعطيل تفاصيل تسجيل الدخول الخاصة بك بسرعة وتعليق وصولك إلى التطبيق في حال كان لديها أي سبب للاعتقاد بأنك قد خرقت أيًا من أحكام هذه الشروط.
        
        التبرعات
        يمكن للمستخدمين إجراء تبرع مالي لـ ShareHup ("التبرع") عبر التطبيق لمساعدتنا في مهمتنا في مكافحة هدر الطعام.
        عندما يتم التبرع عبر التطبيق، فإن العملية نهائية وغير قابلة للنقاش
        
        
        """,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: black, fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
