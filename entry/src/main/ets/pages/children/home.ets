import { LearnDayProp, Word } from "../../model/word";

@Component
export struct HomePage {
  @Consume navStack: NavPathStack;
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  @StorageLink('learnIdx') @Watch('onLearn') learnIdx: Array<number> = []
  @State words: Array<Word> = []
  @State percent: string = '0'
  @State currentType: number = 3;
  private list: Array<string> = ['初中', '高中', '大学', '四级']
  @StorageLink('learnDay') learnDay: LearnDayProp | undefined = undefined

  aboutToAppear(): void {
    const allWorks: Array<Array<Word>> = Object.values(this.jsonWord!);
    this.words = allWorks.flat()
    this.onLearn()
  }

  onLearn() {
    this.percent = (this.learnIdx.length / this.words.length).toFixed(3)
  }

  build() {
    Column({ space: 20 }) {
      Text('学习天数')
      Text(`${this.learnDay?.timer ?? '0'}`).fontSize(24).fontWeight(FontWeight.Bold)

      Grid() {
        ForEach(this.list, (item: string, index: number) => {
          GridItem() {
            Text(item)
          }
          .backgroundColor(this.currentType == index ? 'rgba(13, 187, 60, 0.09)' : '#fff')
          .borderRadius(7)
          .onClick(() => {
            this.currentType = index;
          })
        })
      }
      .columnsGap(10)
      .rowsGap(15)
      .height(100)
      .rowsTemplate('1fr 1fr')
      .columnsTemplate('1fr 1fr')

      Column() {
        Row() {
          Text("核心词汇书")
          Text("词表")
            .fontSize(12)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        Row().height(20)
        Row() {
          Text(`已学${this.percent}%`)
          Text(`${this.learnIdx.length}/${this.words.length}词`)
            .fontSize(12)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        Row().height(8)
        Progress({ value: this.learnIdx.length, total: this.words.length, type: ProgressType.Linear })
      }
      .borderRadius(8)
      .backgroundColor("#fff")
      .padding(16)
      .width('100%')

      Row().height(40)
      Button("开始学习")
        .width('100%')
        .height(54)
        .fontColor('#fff')
        .onClick(() => {
          this.navStack.pushPathByName('learn', undefined)
        })

      Button("开始考试")
        .width('100%')
        .height(54)
        .fontColor('#fff')
        .onClick(() => {
          this.navStack.pushPathByName('exam', undefined)
        })
    }
    .padding({
      top: 50,
      left: 16,
      right: 16
    })
    .height('100%')
    .width('100%')
  }
}