// 脑力运动题库 —— 江西专升本高等数学仿真卷（2025 / 2026）
// 说明：原始文档中的 (\boldsymbol{2}) 均为数字 2，此处已全部还原。
// 题型：
//   choice  单选题：点击选项自动判分
//   judge   判断题：√ / × 自动判分
//   solve   计算 / 证明题：主观题，作答后自评（我答对了 / 看答案）

export const papers = [
  {
    year: '2025',
    title: '2025 江西专升本高数（仿真卷）',
    desc: '满分 150 分 · 10 选择 + 5 判断 + 6 计算 + 1 证明',
    questions: [
      // ===== 一、单项选择题 =====
      {
        type: 'choice',
        q: String.raw`设分段函数 $f(x)=\begin{cases}\arcsin x, & -1\le x\le 0\\ \tan x, & 0<x\le 1\end{cases}$，则 $f\left(\dfrac{\pi}{4}\right)=$（　）`,
        options: [String.raw`$-2$`, String.raw`$-1$`, String.raw`$1$`, String.raw`$2$`],
        answer: 2
      },
      {
        type: 'choice',
        q: String.raw`下列属于周期函数的是（　）`,
        options: [String.raw`$y=x^2$`, String.raw`$y=\sin x$`, String.raw`$y=\ln x$`, String.raw`$y=e^x$`],
        answer: 1
      },
      {
        type: 'choice',
        q: String.raw`$\lim\limits_{n\to\infty}(-1)^n\dfrac{1}{n^2}=$（　）`,
        options: [String.raw`$-1$`, String.raw`$0$`, String.raw`$1$`, String.raw`$2$`],
        answer: 1
      },
      {
        type: 'choice',
        q: String.raw`$x\to 1$ 时，下列是无穷小量的是（　）`,
        options: [String.raw`$y=x$`, String.raw`$y=x+1$`, String.raw`$y=\ln x$`, String.raw`$y=\ln(x+1)$`],
        answer: 2
      },
      {
        type: 'choice',
        q: String.raw`函数 $y=x\ln x$，则 $y'=$（　）`,
        options: [String.raw`$\ln x+1$`, String.raw`$\ln x$`, String.raw`$\dfrac{1}{x}$`, String.raw`$1-\ln x$`],
        answer: 0
      },
      {
        type: 'choice',
        q: String.raw`$\int e^{2x}\,dx=$（　）`,
        options: [String.raw`$2e^{2x}+C$`, String.raw`$\dfrac{1}{2}e^{2x}+C$`, String.raw`$e^{2x}+C$`, String.raw`$-\dfrac{1}{2}e^{2x}+C$`],
        answer: 1
      },
      {
        type: 'choice',
        q: String.raw`二元函数 $z=x^2+y^2$ 在 $(0,0)$ 处（　）`,
        options: ['极大值点', '极小值点', '不是极值点', '间断点'],
        answer: 1
      },
      {
        type: 'choice',
        q: String.raw`微分方程 $\dfrac{dy}{dx}=2xy$ 的通解是（　）`,
        options: [String.raw`$y=Ce^{x^2}$`, String.raw`$y=e^{x^2}+C$`, String.raw`$y=x^2+C$`, String.raw`$y=Ce^{2x}$`],
        answer: 0
      },
      {
        type: 'choice',
        q: String.raw`设 $\int_0^1 f(x)\,dx=2$，则 $\int_0^1 2f(x)\,dx=$（　）`,
        options: [String.raw`$1$`, String.raw`$2$`, String.raw`$4$`, String.raw`$8$`],
        answer: 2
      },
      {
        type: 'choice',
        q: String.raw`曲线 $y=\sqrt{x}$ 与直线 $x=1,\ y=0$ 围成图形的面积是（　）`,
        options: [String.raw`$\dfrac{1}{3}$`, String.raw`$\dfrac{2}{3}$`, String.raw`$1$`, String.raw`$\dfrac{3}{2}$`],
        answer: 1
      },
      // ===== 二、判断题 =====
      {
        type: 'judge',
        q: String.raw`$\lim\limits_{x\to 0}\dfrac{\sin x}{x}=1$`,
        answer: true
      },
      {
        type: 'judge',
        q: '可导一定连续，连续一定可导',
        answer: false
      },
      {
        type: 'judge',
        q: String.raw`奇函数在对称区间 $[-a,a]$ 上的定积分等于 $0$`,
        answer: true
      },
      {
        type: 'judge',
        q: String.raw`$y=\sin^2 x$ 的导数是 $y'=\sin 2x$`,
        answer: true
      },
      {
        type: 'judge',
        q: String.raw`二重积分 $\iint_D d\sigma$ 代表区域 $D$ 的面积`,
        answer: true
      },
      // ===== 三、计算题 =====
      {
        type: 'solve',
        q: String.raw`求极限：$\lim\limits_{x\to 0}\dfrac{1-\cos 2x}{x^2}$`,
        answer: String.raw`$2$`
      },
      {
        type: 'solve',
        q: String.raw`设 $y=e^{x^2}+\ln(1+x)$，求 $y'$`,
        answer: String.raw`$y'=2x\,e^{x^2}+\dfrac{1}{1+x}$`
      },
      {
        type: 'solve',
        q: String.raw`求不定积分：$\int \dfrac{1}{1+x^2}\,dx$`,
        answer: String.raw`$\arctan x + C$`
      },
      {
        type: 'solve',
        q: String.raw`求定积分：$\int_0^2 (x+1)\,dx$`,
        answer: String.raw`$4$`
      },
      {
        type: 'solve',
        q: String.raw`求微分方程 $\dfrac{dy}{dx}=-\dfrac{x}{y}$，$y(0)=2$ 的特解`,
        answer: String.raw`$x^2+y^2=4$`
      },
      {
        type: 'solve',
        q: String.raw`求由 $y=x^2,\ y=x$ 围成图形：① 面积；② 绕 $x$ 轴旋转的体积`,
        answer: String.raw`① $\dfrac{1}{6}$；② $\dfrac{2\pi}{15}$`
      },
      // ===== 四、证明题 =====
      {
        type: 'solve',
        q: String.raw`证明不等式：当 $x>0$ 时，$\ln(1+x)<x$`,
        answer: String.raw`构造 $F(x)=\ln(1+x)-x$，$F'(x)=\dfrac{1}{1+x}-1<0$，故 $F(x)$ 单调递减，$F(0)=0$，所以 $x>0$ 时 $F(x)<0$，即 $\ln(1+x)<x$。`
      }
    ]
  },
  {
    year: '2026',
    title: '2026 江西专升本高数（仿真卷·回忆版改编）',
    desc: '满分 150 分 · 10 选择 + 5 判断 + 6 计算 + 1 证明',
    questions: [
      // ===== 一、单项选择题 =====
      {
        type: 'choice',
        q: String.raw`函数 $y=x^2\ (x\ge 0)$ 的反函数是（　）`,
        options: [String.raw`$y=-\sqrt{x}$`, String.raw`$y=\sqrt{x}$`, String.raw`$y=\pm\sqrt{x}$`, String.raw`$y=x$`],
        answer: 1
      },
      {
        type: 'choice',
        q: String.raw`设 $f(x)=\dfrac{1}{x+1}$，则 $f'(0)=$（　）`,
        options: [String.raw`$-1$`, String.raw`$-\dfrac{1}{2}$`, String.raw`$1$`, String.raw`$\dfrac{1}{2}$`],
        answer: 0
      },
      {
        type: 'choice',
        q: String.raw`$\lim\limits_{x\to 1}\dfrac{2x^2-3x+1}{x^2-1}=$（　）`,
        options: [String.raw`$-2$`, String.raw`$0$`, String.raw`$1$`, String.raw`$2$`],
        answer: 2
      },
      {
        type: 'choice',
        q: String.raw`$f(x)=\begin{cases}x^2-a, & x\le 0\\ 3x, & x>0\end{cases}$ 在 $x=0$ 处连续，则 $a=$（　）`,
        options: [String.raw`$-1$`, String.raw`$0$`, String.raw`$1$`, String.raw`$2$`],
        answer: 1
      },
      {
        type: 'choice',
        q: String.raw`$y=x\ln x$，$y'=$（　）`,
        options: [String.raw`$\dfrac{1}{x}$`, String.raw`$\ln x+1$`, String.raw`$\ln x$`, String.raw`$-\dfrac{1}{x}$`],
        answer: 1
      },
      {
        type: 'choice',
        q: String.raw`$\int e^{-x}\,dx=$（　）`,
        options: [String.raw`$-e^{-x}+C$`, String.raw`$e^{-x}+C$`, String.raw`$e^{x}+C$`, String.raw`$-e^{x}+C$`],
        answer: 0
      },
      {
        type: 'choice',
        q: String.raw`$\lim\limits_{x\to 0}\dfrac{\sin 3x}{x}=$（　）`,
        options: [String.raw`$1$`, String.raw`$2$`, String.raw`$3$`, String.raw`$0$`],
        answer: 2
      },
      {
        type: 'choice',
        q: String.raw`微分方程 $y''=0$ 的通解是（　）`,
        options: [String.raw`$y=C_1x+C_2$`, String.raw`$y=C_1\sin x+C_2$`, String.raw`$y=C_1e^x+C_2$`, String.raw`$y=C_1e^{2x}+C_2$`],
        answer: 0
      },
      {
        type: 'choice',
        q: String.raw`$z=5-x^2-y^2$ 的极大值点是（　）`,
        options: [String.raw`$(0,0)$`, String.raw`$(0,1)$`, String.raw`$(1,0)$`, String.raw`$(-1,1)$`],
        answer: 0
      },
      {
        type: 'choice',
        q: String.raw`$z=e^{xy}$，则 $\dfrac{\partial z}{\partial x}=$（　）`,
        options: [String.raw`$e^{xy}$`, String.raw`$ye^{xy}$`, String.raw`$xe^{xy}$`, String.raw`$xye^{xy}$`],
        answer: 1
      },
      // ===== 二、判断题 =====
      {
        type: 'judge',
        q: String.raw`$x\to 0$ 时，$1-\cos x$ 与 $\dfrac{1}{2}x^2$ 是等价无穷小`,
        answer: true
      },
      {
        type: 'judge',
        q: String.raw`$y=x^3-2x^2+x+2$ 的单调递减区间包含 $\left[\dfrac{1}{3},1\right]$`,
        answer: true
      },
      {
        type: 'judge',
        q: String.raw`$f(x)=|x|$ 在 $x=0$ 处可导`,
        answer: false
      },
      {
        type: 'judge',
        q: String.raw`若 $\int_a^b f(x)\,dx=0$，则必有 $f(x)\equiv 0$`,
        answer: false
      },
      {
        type: 'judge',
        q: '可微二元函数一定存在偏导数',
        answer: true
      },
      // ===== 三、计算题 =====
      {
        type: 'solve',
        q: String.raw`$\lim\limits_{x\to 0}\left(\dfrac{1}{x}-\dfrac{1}{e^x-1}\right)$`,
        answer: String.raw`$\dfrac{1}{2}$`
      },
      {
        type: 'solve',
        q: String.raw`求 $f(x)=e^x-x+1$ 的极值`,
        answer: String.raw`极小值 $f(0)=2$，无极大值`
      },
      {
        type: 'solve',
        q: String.raw`不定积分：$\int \dfrac{1}{x\sqrt{x}}\,dx$`,
        answer: String.raw`$-\dfrac{2}{\sqrt{x}}+C$`
      },
      {
        type: 'solve',
        q: String.raw`微分方程 $\dfrac{dy}{dx}=y^2$，$y(0)=1$ 的特解`,
        answer: String.raw`$y=\dfrac{1}{1-x}$`
      },
      {
        type: 'solve',
        q: String.raw`二重积分 $\iint_D x\,d\sigma$，其中 $D$ 由 $y=x,\ y=0,\ x=1$ 围成`,
        answer: String.raw`$\dfrac{1}{3}$`
      },
      {
        type: 'solve',
        q: String.raw`曲线 $y=\sqrt{x}$ 和 $y=x$ 围成图形：① 面积；② 绕 $x$ 轴旋转的体积`,
        answer: String.raw`① $\dfrac{1}{6}$；② $\dfrac{\pi}{6}$`
      },
      // ===== 四、证明题 =====
      {
        type: 'solve',
        q: String.raw`求证：$f(x)=x^3-3x+1$ 在 $(0,1)$ 内至少存在一个零点`,
        answer: String.raw`$f(x)$ 在 $[0,1]$ 上连续，$f(0)=1>0$，$f(1)=-1<0$，由零点存在定理，存在 $\xi\in(0,1)$ 使 $f(\xi)=0$。`
      }
    ]
  }
]
