import { buffer } from "@kit.ArkTS";

@Component
export struct Learn {
  @State message: string = 'Hello World';

  aboutToAppear(): void {
    this.getRawFile()
  }

  getRawFile() {
    try {
      let data: Uint8Array = getContext(this).resourceManager.getRawFileContentSync("a.json");
      const str = buffer.from(data.buffer).toString('utf-8');
      console.log((JSON.parse(str)['a']))
    } catch (e) {
      console.info(JSON.stringify(e))
    }
  }

  build() {
    NavDestination() {
      Column() {
        Row().height(20)
        Row() {
          Column({ space: 8 }) {
            Text("今日复习")
            Text("0/0")
          }

          Column({ space: 8 }) {
            Text("今日新词")
            Text("0/0")
          }

          Column({ space: 8 }) {
            Text("学习时间")
            Text("1min")
          }
        }
        .borderRadius(2)
        .padding(16)
        .backgroundColor('#fff')
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .padding({ left: 16, right: 16 })
    }
    .title("learn")
    .padding({
      top: 40,
    })
    .backgroundColor('#F8F9FB')
    .backgroundImage($r('app.media.person_bg'))
  }
}