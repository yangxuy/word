import { inputMethod } from '@kit.IMEKit';
import { emitter } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';

@Extend(Text)
function verifyCodeUnitStyle() {
  .fontSize($r("sys.float.ohos_id_text_size_body1"))
  .fontWeight(60)
  .textAlign(TextAlign.Center)
  .width('100%')
  .height('100%')
  .margin({
    left: 10,
    right: 10
  })
  .border({
    width: { bottom: 1 },
    color: { bottom: Color.Grey },
    style: { bottom: BorderStyle.Solid }
  })
}

@Component
export struct VerifyCodeComponentWithoutCursor {
  @State codeText: string = "";
  @Prop @Watch('onChangeWord') currentWord: string;
  @Prop currentWordIdx: number;
  @StorageLink('unknownIdx') unknownIdx: Array<number> = []
  private readonly verifyID: string = "verifyCodeComponent";
  private inputController: inputMethod.InputMethodController = inputMethod.getController();
  // 监听键盘弹出收起状态
  @State isKeyboardShow: boolean = false;
  private isListen: boolean = false;
  private textConfig: inputMethod.TextConfig = {
    inputAttribute: {
      textInputType: inputMethod.TextInputType.TEXT,
      enterKeyType: inputMethod.EnterKeyType.GO
    },
  };
  onClear: () => void = () => {
  };
  onFinish: (text: string, cu: string) => void = () => {
  };
  onError: () => void = () => {
  };
  onRight: () => void = () => {
  };
  // 注册路由返回函数，案例插件不触发
  popRouter: () => void = () => {
  };

  aboutToAppear(): void {
    console.log(this.currentWord)
    // 注册返回监听，包括点击手机返回键返回与侧滑返回
    this.listenBackPress();
    this.listenClear()
  }

  onChangeWord() {
    this.codeText = ""
  }

  async attachAndListen(): Promise<void> {
    focusControl.requestFocus(this.verifyID);
    await this.inputController.attach(true, this.textConfig);
    this.listen();
    this.isKeyboardShow = true;
  }

  listenClear() {
    let innerEvent: emitter.InnerEvent = {
      eventId: 6
    };
    // 收到eventId为5的事件后执行回调函数
    emitter.on(innerEvent, () => {
      this.codeText = ''
    });
  }

  listenBackPress() {
    let innerEvent: emitter.InnerEvent = {
      eventId: 5
    };
    // 收到eventId为5的事件后执行回调函数
    emitter.on(innerEvent, () => {
      if (this.isKeyboardShow) {
        // 退出文本编辑状态
        this.inputController.hideTextInput();
        this.isKeyboardShow = false;
      } else {
        this.popRouter();
      }
    });
  }

  aboutToDisappear(): void {
    this.off();
    // 关闭事件监听
    emitter.off(5);
    emitter.off(6);
  }

  async attach() {
    await this.inputController.attach(true, this.textConfig);
  }

  /**
   * TODO：知识点：解绑
   */
  off(): void {
    this.inputController.off("insertText");
    this.inputController.off("deleteLeft");
    this.isListen = false;
    // 退出文本编辑状态
    this.inputController.hideTextInput();
    this.isKeyboardShow = false;
  }

  listen() {
    if (this.isListen) {
      return;
    }
    this.inputController.on("insertText", (text: string) => {
      if (this.codeText.length >= this.currentWord.length || text === ' ') {
        return;
      }
      this.codeText += text;
      if (this.codeText.length === this.currentWord.length) {
        if (this.codeText != this.currentWord) {
          this.getUIContext().getPromptAction().showToast({
            message: "回答错误",
            duration: 2000,
            showMode: promptAction.ToastShowMode.TOP_MOST,
            bottom: 80,
            backgroundColor: "red",
          })
          if (!this.unknownIdx.includes(this.currentWordIdx)) {
            this.unknownIdx.push(this.currentWordIdx)
          }
          this.onError()
        } else {
          this.getUIContext().getPromptAction().showToast({
            message: "回答正确",
            duration: 2000,
            showMode: promptAction.ToastShowMode.TOP_MOST,
            bottom: 80,
            backgroundColor: "red",
          })
          this.codeText = ""
          this.onRight()
        }
        this.onFinish(this.codeText, this.currentWord)
      }
    })

    this.inputController.on("deleteLeft", (length: number) => {
      this.codeText = this.codeText.substring(0, this.codeText.length - 1);
    })
    this.isListen = true;
  }

  /**
   * TODO 知识点：部分验证码场景要完全禁止对输入验证码的选中、复制等功能，因此可以使用Text组件完成
   */
  @Builder
  buildVerifyCodeComponent() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
      ForEach(this.currentWord.split(''), (item: number, index: number) => {
        Text(this.codeText[index] ?? "")
          .verifyCodeUnitStyle()
      }, (item: number, index: number) => item.toString())
    }
    .id(this.verifyID)
    .onBlur(() => {
      this.off();
    })
    .backgroundColor(Color.Transparent)
    .height(50)
    .defaultFocus(true)
    .onClick(() => {
      this.attachAndListen();
    })
  }

  build() {
    Row() {
      this.buildVerifyCodeComponent()
    }
  }
}