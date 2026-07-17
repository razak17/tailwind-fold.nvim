import { Check } from 'lucide-react'

import { cn } from '@/lib/utils'

import { Card, CardContent, CardFooter, CardHeader } from '@/components/ui/card'

type CourseCardProps = {
  title: string
  id: number
  imageSrc: string
  onClick: (id: number) => void
  disabled?: boolean
  active?: boolean
}

const col = '#ff0000'

export function CourseCard({
  title,
  id,
  imageSrc,
  disabled,
  onClick,
  active,
}: CourseCardProps) {
  return (
    <Card
      onClick={() => onClick(id)}
      className={cn(
        'h-full min-h-[217px] min-w-[200px] cursor-pointer items-center justify-between border-2 border-b-4 p-3 pb-6 hover:bg-black/5 active:border-b-2',
        disabled && 'pointer-events-none opacity-50',
      )}
    >
      <CardHeader className="min-[24px] flex w-full items-center justify-end p-0">
        {active && (
          <div className="flex items-center justify-center rounded-md bg-green-600 p-1.5">
            <Check className="h-4 w-4 stroke-[4] text-black" />
          </div>
        )}
      </CardHeader>
      <CardContent className="flex justify-center p-0">
        <img
          src={imageSrc}
          alt={title}
          height={70}
          width={93.33}
          className="rounded-lg border object-cover drop-shadow-md"
        />
      </CardContent>
      <CardFooter className="justify-center p-0">
        <p className="mt-3 text-center font-bold text-neutral-700">{title}</p>
      </CardFooter>
    </Card>
  )
}
