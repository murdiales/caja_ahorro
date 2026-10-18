import './styles/app.css';

import {
    Chart,

    LineController,
    LineElement,
    PointElement,

    BarController,
    BarElement,

    DoughnutController,
    ArcElement,

    LinearScale,
    CategoryScale,

    Tooltip,
    Legend,
    Filler
} from 'chart.js';

Chart.register(
    LineController,
    LineElement,
    PointElement,

    BarController,
    BarElement,

    DoughnutController,
    ArcElement,

    LinearScale,
    CategoryScale,

    Tooltip,
    Legend,
    Filler
);

window.Chart = Chart;
